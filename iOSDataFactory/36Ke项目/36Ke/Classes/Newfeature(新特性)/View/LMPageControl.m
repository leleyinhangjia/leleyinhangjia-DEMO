//
//  LMPageControl.m
//  36Ke
//
//  Created by lmj  on 16/3/2.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import "LMPageControl.h"

#define DEFAULT_INDICATOR_DIAMETER 6.0f
#define DEFAULT_INDICATOR_MARGIN 10.0f
#define DEFAULT_MIN_HEIGHT 36.0f

#define DEFAULT_INDICATOR_DIAMETER_LARGE 7.0f
#define DEFAULT_INDICATOR_MARGIN_LARGE 9.0f
#define DEFAULT_MIN_HEIGHT_LARGE 36.0f

typedef NS_ENUM(NSUInteger, LMPageControlImageType) {
    
    LMPageControlImageTypeNormal = 1,
    LMPageControlImageTypeCurrent,
    LMPageControlImageTypeMask
};

typedef NS_ENUM(NSUInteger, LMPageControlStyleDefaults) {
    
    LMPageControlImageTypeClassic = 0,
    LMPageControlImageTypeModern
};

static LMPageControlStyleDefaults _defaultControlStyleDefaults;

@interface LMPageControl()

/**
 *  索引名称
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *pageNames;

/**
 *  其他页面小点图片
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *pageImages;

/**
 * 当面页面小点图片
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *currentPageImages;

/**
 *  页面遮盖索引
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *pageImageMasks;

@property (nonatomic, strong, readonly) NSMutableDictionary *cgImageMasks;

/**
 *  页面锯齿
 */
@property (nonatomic, strong, readwrite) NSArray *pageRects;

// 页面控制用于窃取页码本地化辅助功能标签
// 我不知道我喜欢这种技术，但它是获得所有语言的翻译准确的最佳方式
// 苹果支持开箱即用
@property (nonatomic, strong) UIPageControl *pageControl;

@end



@implementation LMPageControl
{
@private
    NSInteger   _displayedPage;
    CGFloat     _measuredIndicatorWidth;
    CGFloat     _measuredIndicatorHeight;
    CGImageRef  _pageImageMask;
}

@synthesize pageNames = _pageNames;
@synthesize pageImages = _pageImages;
@synthesize currentPageImages = _currentPageImages;
@synthesize pageImageMasks = _pageImageMasks;
@synthesize cgImageMasks = _cgImageMasks;

+ (void)initialize {
    
    NSString *reqSysVer = @"7.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending) {
        // 现代风格
        _defaultControlStyleDefaults = LMPageControlImageTypeModern;
    } else {
        _defaultControlStyleDefaults = LMPageControlImageTypeClassic;
    }
    
}

- (void)_initialize {
    
    _numberOfPages = 0;
//    _tapBehavior = LMPageControlTapBehaviorStep
    // 提供递增/递减就像uipagecontrol行为
    _tapBehavior = LMPageControlTapBehaviorStep;
    
    self.backgroundColor = [UIColor clearColor];
#ifdef __IPHONE_7_0
    [self setStyleWithDefaults:_defaultControlStyleDefaults];
#else
    [self setStyleWithDefaults:LMPageControlDefaultStyleClassic];
#endif
    _alignment = LMPageControlAlignmentCenter;
    _verticalAlignment = LMPageControlVerticalAlignmentMiddle;
    
    // 一个布尔值，该值指示是否该接收器是一个辅助应用程序可以访问的可访问性元素。
    self.isAccessibilityElement = YES;
    /**
     * 相结合的最佳表征的可访问性元素的可访问性特征。
     此属性的默认值是 UIAccessibilityTraitNone，除非接收器是 UIKit 控件，其值是一组标准的与该控件关联的性状。
     如果实现自定义控件或视图，您需要选择所有辅助功能性状最好描述对象，和他们结合其超类的性状 (换句话说，与 super.accessibilityTraits)，通过执行或运算。性状的完整列表，请参阅辅助功能特征。
     
     * UIAccessibilityTraitUpdatesFrequently:使用时该元素经常更新其标签或价值，但往往对发送通知。
     允许辅助功能客户端轮询更改。秒表就是一个例子。
     
     
      */
    self.accessibilityTraits = UIAccessibilityTraitUpdatesFrequently;
    // 缩放以填充固定方面的内容。部分内容可能会剪裁。
    self.pageControl = [[UIPageControl alloc] init];
    self.contentMode = UIViewContentModeRedraw;
//    _num = 0;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (nil == self) {
        return nil;
    }
    [self _initialize];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (nil == self) {
        return nil;
    }
    [self _initialize];
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self _renderPages:context rect:rect];
}

- (void)_renderPages:(CGContextRef)context rect:(CGRect)rect {
    
    /**
     * 创建并返回一个NSMutableArray对象，具有足够的已 分配的内存 最初容纳对象的给定数目。
       可变数组按需扩展; numItems的只是建立对象的初始容量。
     */
    NSMutableArray *pageRects = [NSMutableArray arrayWithCapacity:self.numberOfPages];
    
    if (_numberOfPages < 2 && _hidesForSinglePage) {
        return ;
    }
    
    CGFloat left = [self _leftOffset];
    
    CGFloat xOffset = left;
    CGFloat yOffset = 0.0f;
    UIColor *fillColor = nil;
    UIImage *image = nil;
    CGImageRef maskingImage = nil;
    CGSize maskSize = CGSizeZero;
    
    for (NSInteger i = 0; i < _numberOfPages; i++) {
        NSNumber *indexNumber = @(i);
        
        if (i == _displayedPage) {
            fillColor = _currentPageIndicatorTintColor ? _currentPageIndicatorTintColor : [UIColor whiteColor];
            image = _currentPageImages[indexNumber];
            if (nil == image) {
                image = _currentPageIndicatorImage;
            }
        } else {
            fillColor = _pageIndicatorTintColor ? _pageIndicatorTintColor : [[UIColor whiteColor] colorWithAlphaComponent:0.3f];
            image = _pageImages[indexNumber];
            if (nil == image) {
                image = _pageIndicatorImage;
            }
        }
        
        // If no finished images have been set, try a masking image
        if (nil == image) {
            maskingImage = (__bridge CGImageRef)_cgImageMasks[indexNumber];
            UIImage *originalImage = _pageImageMasks[indexNumber];
            maskSize = originalImage.size;
            
            // If no per page mask is set, try for a global page mask!
            if (nil == maskingImage) {
                maskingImage = _pageImageMask;
                maskSize = _pageIndicatorMaskImage.size;
            }
        }
        
        [fillColor set];
        CGRect indicatorRect;
        if (image) {
            yOffset = [self _topOffsetForHeight:image.size.height rect:rect];
            CGFloat centeredXOffset = xOffset + floorf((_measuredIndicatorWidth - image.size.width) / 2.0f);
            [image drawAtPoint:CGPointMake(centeredXOffset, yOffset)];
            indicatorRect = CGRectMake(centeredXOffset, yOffset, image.size.width, image.size.height);
        } else if (maskingImage) {
            yOffset = [self _topOffsetForHeight:maskSize.height rect:rect];
            CGFloat centeredXOffset = xOffset + floorf((_measuredIndicatorWidth - maskSize.width) / 2.0f);
            indicatorRect = CGRectMake(centeredXOffset, yOffset, maskSize.width, maskSize.height);
            CGContextDrawImage(context, indicatorRect, maskingImage);
        } else {
            yOffset = [self _topOffsetForHeight:_indicatorDiameter rect:rect];
            CGFloat centeredXOffset = xOffset + floorf((_measuredIndicatorWidth - _indicatorDiameter) / 2.0f);
            indicatorRect = CGRectMake(centeredXOffset, yOffset, _indicatorDiameter, _indicatorDiameter);
            CGContextFillEllipseInRect(context, indicatorRect);
        }
        
        [pageRects addObject:[NSValue valueWithCGRect:indicatorRect]];
        maskingImage = NULL;
        xOffset += _measuredIndicatorWidth + _indicatorMargin;
    }
    
    self.pageRects = pageRects;
}

- (CGFloat)_topOffsetForHeight:(CGFloat)height rect:(CGRect)rect {
    
    CGFloat top = 0.0f;
    switch (_verticalAlignment) {
        case LMPageControlVerticalAlignmentMiddle:
            top = CGRectGetMidY(rect) - (height / 2.0f);
            break;
        case LMPageControlVerticalAlignmentBottom:
            top = CGRectGetMaxY(rect) - height;
        default:
            break;
    }
    
    return top;
}

- (CGFloat)_leftOffset {
    
    CGRect rect = self.bounds;
    CGSize size = [self sizeForNumberOfPages:self.numberOfPages];
    CGFloat left = 0.0f;
    switch (_alignment) {
        case LMPageControlAlignmentCenter:
            left = ceilf(CGRectGetMidX(rect) - (size.width / 2.0f));
            break;
        case LMPageControlAlignmentRight:
            left = CGRectGetMaxX(rect) - size.width;
            break;
        default:
            break;
    }
    
    return left;
}



- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount {
    CGFloat marginSpace = MAX(0, pageCount - 1) * _indicatorMargin;
    CGFloat indicatorSpace = pageCount * _measuredIndicatorWidth;
    CGSize size = CGSizeMake(marginSpace + indicatorSpace, _measuredIndicatorHeight);
    return size;
}

- (CGSize)sizeThatFits:(CGSize)size {
    
    CGSize sizeThatFits = [self sizeForNumberOfPages:self.numberOfPages];
    sizeThatFits.height = MAX(sizeThatFits.height, _minHeight);
    return sizeThatFits;
}

- (CGSize)intrinsicContentSize {
    
    if (_numberOfPages < 1 || (_numberOfPages < 2 && _hidesForSinglePage)) {
        return CGSizeMake(UIViewNoIntrinsicMetric, 0.0f);
    }
    CGSize intrinsicMetric = CGSizeMake(UIViewNoIntrinsicMetric, MAX(_measuredIndicatorHeight, _minHeight));
    return intrinsicMetric;
}

- (void)updatePageNumberForScrollView:(UIScrollView *)scrollView {
    
    NSInteger page = (int)floorf(scrollView.contentOffset.x / scrollView.bounds.size.width);
    self.currentPage = page;
}

- (void)setScrollViewContentOffsetForCurrentPage:(UIScrollView *)scrollView  animated:(BOOL)animated{
    
    CGPoint offset = scrollView.contentOffset;
    offset.x = scrollView.bounds.size.width * self.currentPage;
    [scrollView setContentOffset:offset animated:animated];
    
}



- (void)setStyleWithDefaults:(LMPageControlStyleDefaults)defaultStyle {
    
    switch (defaultStyle) {
        case LMPageControlImageTypeModern:
            self.indicatorDiameter = DEFAULT_INDICATOR_DIAMETER_LARGE;
            self.indicatorMargin = DEFAULT_INDICATOR_MARGIN_LARGE;
            self.pageIndicatorTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2f];
            self.minHeight = DEFAULT_MIN_HEIGHT_LARGE;
            break;
        case LMPageControlImageTypeClassic:
        default:
            self.indicatorMargin = DEFAULT_INDICATOR_MARGIN;
            self.indicatorDiameter = DEFAULT_INDICATOR_DIAMETER;
            self.minHeight = DEFAULT_MIN_HEIGHT;
            break;
    }
}



- (CGImageRef)createMaskForImage:(UIImage *)image {
    
    size_t pixelsWide = image.size.width * image.scale;
    size_t pixelsHigh = image.size.height * image.scale;
    size_t bitmapBytesPerRow = (pixelsWide * 1);
    CGContextRef context = CGBitmapContextCreate(NULL, pixelsWide, pixelsHigh, CGImageGetBitsPerComponent(image.CGImage), bitmapBytesPerRow, NULL, (CGBitmapInfo)kCGImageAlphaOnly);
    CGContextTranslateCTM(context, 0.f, pixelsHigh);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    CGContextDrawImage(context, CGRectMake(0, 0, pixelsWide, pixelsHigh), image.CGImage);
    CGImageRef maskImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    return maskImage;
}


- (void)updateCurrentPageDisplay {
    _displayedPage = _currentPage;
    [self setNeedsDisplay];
}

- (CGRect)rectForPageIndicator:(NSInteger)pageIndex {
    
    if (pageIndex < 0 || pageIndex >= _numberOfPages) {
        return CGRectZero;
    }
    
    CGFloat left = [self _leftOffset];
    CGSize size = [self sizeForNumberOfPages:pageIndex + 1];
    CGRect rect = CGRectMake(left + size.width - _measuredIndicatorWidth, 0, _measuredIndicatorWidth, _measuredIndicatorWidth);
    
    return rect;
}

- (void)_setImage:(UIImage *)image forPage:(NSInteger)pageIndex type:(LMPageControlImageType)type {
    if (pageIndex < 0 || pageIndex >= _numberOfPages) {
        return ;
    }
    
    NSMutableDictionary *dictionary = nil;
    switch (type) {
        case LMPageControlImageTypeCurrent:
            dictionary = self.currentPageImages;
            break;
        case LMPageControlImageTypeNormal:
            dictionary = self.pageImages;
        case LMPageControlImageTypeMask:
            dictionary = self.pageImageMasks;
        default:
            break;
    }
    
    if (image) {
        dictionary[@(pageIndex)] = image;
    } else {
        [dictionary removeObjectForKey:@(pageIndex)];
    }
}

- (void)setImage:(UIImage *)image forPage:(NSInteger)pageIndex {
    [self _setImage:image forPage:pageIndex type:LMPageControlImageTypeNormal];
    [self _updateMeasuredIndicatorSizes];
}

- (void)setCurrentImage:(UIImage *)image forPage:(NSInteger)pageIndex {
    
    [self _setImage:image forPage:pageIndex type:LMPageControlImageTypeCurrent];
    [self _updateMeasuredIndicatorSizes];
}

- (void)setImageMask:(UIImage *)image forPage:(NSInteger)pageIndex {
    
    [self _setImage:image
            forPage:pageIndex type:LMPageControlImageTypeMask];
    if (nil == image) {
        [self.cgImageMasks removeObjectForKey:@(pageIndex)];
        return;
    }
    CGImageRef maskImage = [self createMaskForImage:image];
    
    if (maskImage) {
        self.cgImageMasks[@(pageIndex)] = (__bridge id)(maskImage);
        CGImageRelease(maskImage);
        [self _updateMeasuredIndicatorSizes];
        [self setNeedsDisplay];
    }
    
//    [self _updateMeasuredIndicatorSizes];
}

- (id)_imageForPage:(NSInteger)pageIndex type:(LMPageControlImageType)type {
    
    if (pageIndex < 0 || pageIndex >= self.numberOfPages) {
        return nil;
    }
    
    NSDictionary *dictionary = nil;
    switch (type) {
        case LMPageControlImageTypeNormal:
            dictionary = _pageImages;
            break;
        case LMPageControlImageTypeCurrent:
            dictionary = _currentPageImages;
            break;
        case LMPageControlImageTypeMask:
            dictionary = _pageImageMasks;
            break;
        default:
            break;
    }
    return dictionary[@(pageIndex)];
}

- (UIImage *)imageForPage:(NSInteger)pageIndex
{
    return [self _imageForPage:pageIndex type:LMPageControlImageTypeNormal];
}

- (UIImage *)currentImageForPage:(NSInteger)pageIndex
{
    return [self _imageForPage:pageIndex type:LMPageControlImageTypeCurrent];
}

- (UIImage *)imageMaskForPage:(NSInteger)pageIndex
{
    return [self _imageForPage:pageIndex type:LMPageControlImageTypeMask];
}

- (void)_updateMeasuredIndicatorSizes {
    
    _measuredIndicatorWidth = _indicatorDiameter;
    _measuredIndicatorHeight = _indicatorDiameter;
    
    // If we're only using images, ignore the _indicatorDiameter
    if ( (self.pageIndicatorImage || self.pageIndicatorMaskImage) && self.currentPageIndicatorImage )
    {
        _measuredIndicatorWidth = 0;
        _measuredIndicatorHeight = 0;
    }
    
    if (self.pageIndicatorImage) {
        [self _updateMeasuredIndicatorSizeWithSize:self.pageIndicatorImage.size];
    }
    
    if (self.currentPageIndicatorImage) {
        [self _updateMeasuredIndicatorSizeWithSize:self.currentPageIndicatorImage.size];
    }
    
    if (self.pageIndicatorMaskImage) {
        [self _updateMeasuredIndicatorSizeWithSize:self.pageIndicatorMaskImage.size];
    }
    
    if ([self respondsToSelector:@selector(invalidateIntrinsicContentSize)]) {
        [self invalidateIntrinsicContentSize];
    }
}

- (void)_updateMeasuredIndicatorSizeWithSize:(CGSize)size {
    _measuredIndicatorWidth = MAX(_measuredIndicatorWidth, size
                                  .width);
    _measuredIndicatorHeight = MAX(_measuredIndicatorHeight, size.height);
}

#pragma mark - Tap Gesture

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    if (LMPageControlTapBehaviorJump == self.tapBehavior) {
        
        __block NSInteger tappedIndicatorIndex = NSNotFound;
        
        [self.pageRects enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger index, BOOL *stop) {
            CGRect indicatorRect = [value CGRectValue];
            
            if (CGRectContainsPoint(indicatorRect, point)) {
                tappedIndicatorIndex = index;
                *stop = YES;
            }
        }];
        
        if (NSNotFound != tappedIndicatorIndex) {
            [self setCurrentPage:tappedIndicatorIndex sendEvent:YES canDefer:YES];
            return;
        }
    }
    
    CGSize size = [self sizeForNumberOfPages:self.numberOfPages];
    CGFloat left = [self _leftOffset];
    CGFloat middle = left + (size.width / 2.0f);
    if (point.x < middle) {
        [self setCurrentPage:self.currentPage - 1 sendEvent:YES canDefer:YES];
    } else {
        [self setCurrentPage:self.currentPage + 1 sendEvent:YES canDefer:YES];
    }
}

#pragma mark - Accessors

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)setIndicatorDiameter:(CGFloat)indicatorDiameter
{
    if (indicatorDiameter == _indicatorDiameter) {
        return;
    }
    
    _indicatorDiameter = indicatorDiameter;
    
    // Absolute minimum height of the control is the indicator diameter
    if (_minHeight < indicatorDiameter) {
        self.minHeight = indicatorDiameter;
    }
    
    [self _updateMeasuredIndicatorSizes];
    [self setNeedsDisplay];
}

- (void)setIndicatorMargin:(CGFloat)indicatorMargin
{
    if (indicatorMargin == _indicatorMargin) {
        return;
    }
    
    _indicatorMargin = indicatorMargin;
    [self setNeedsDisplay];
}

- (void)setMinHeight:(CGFloat)minHeight
{
    if (minHeight == _minHeight) {
        return;
    }
    
    // Absolute minimum height of the control is the indicator diameter
    if (minHeight < _indicatorDiameter) {
        minHeight = _indicatorDiameter;
    }
    
    _minHeight = minHeight;
    if ([self respondsToSelector:@selector(invalidateIntrinsicContentSize)]) {
        [self invalidateIntrinsicContentSize];
    }
    [self setNeedsLayout];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    if (numberOfPages == _numberOfPages) {
        return;
    }
    
    self.pageControl.numberOfPages = numberOfPages;
    
    _numberOfPages = MAX(0, numberOfPages);
    if ([self respondsToSelector:@selector(invalidateIntrinsicContentSize)]) {
        [self invalidateIntrinsicContentSize];
    }
    [self updateAccessibilityValue];
    [self setNeedsDisplay];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    
    [self setCurrentPage:currentPage sendEvent:NO canDefer:NO];
}

- (void)setCurrentPage:(NSInteger)currentPage sendEvent:(BOOL)sendEvent canDefer:(BOOL)defer {
    
    _currentPage = MIN(MAX(0, currentPage), _numberOfPages - 1);
    self.pageControl.currentPage = self.currentPage;
    
    if (NO == self.defersCurrentPageDisplay || NO == defer) {
        _displayedPage = _currentPage;
        [self setNeedsDisplay];
    }
    
    if (sendEvent) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
}

- (void)setCurrentPageIndicatorImage:(UIImage *)currentPageIndicatorImage {
    if (!currentPageIndicatorImage || [currentPageIndicatorImage isEqual:_currentPageIndicatorImage]) {
        return ;
    }
    
    _currentPageIndicatorImage = currentPageIndicatorImage;
    [self _updateMeasuredIndicatorSizes];
    [self setNeedsDisplay];
}

- (void)setPageIndicatorImage:(UIImage *)pageIndicatorImage {
    if ([pageIndicatorImage isEqual:_pageIndicatorImage]) {
        return;
    }
    
    _pageIndicatorImage = pageIndicatorImage;
    [self _updateMeasuredIndicatorSizes];
    [self setNeedsDisplay];
}

- (void)setPageIndicatorMaskImage:(UIImage *)pageIndicatorMaskImage {
    if ([pageIndicatorMaskImage isEqual:_pageIndicatorMaskImage]) {
        return ;
    }
    
    _pageIndicatorMaskImage = pageIndicatorMaskImage;
    if (_pageImageMask) {
        CGImageRelease(_pageImageMask);
    }
    
    _pageImageMask = [self createMaskForImage:_pageIndicatorMaskImage];
    
    [self _updateMeasuredIndicatorSizes];
    [self setNeedsDisplay];
}

- (NSMutableDictionary *)pageNames {
    
    if (nil != _pageNames) {
        return _pageNames;
    }
    _pageNames = [[NSMutableDictionary alloc] init];
    return _pageNames;
}

- (NSMutableDictionary *)currentPageImages
{
    if (nil != _currentPageImages) {
        return _currentPageImages;
    }
    
    _currentPageImages = [[NSMutableDictionary alloc] init];
    return _currentPageImages;
}

- (NSMutableDictionary *)pageImageMasks
{
    if (nil != _pageImageMasks) {
        return _pageImageMasks;
    }
    
    _pageImageMasks = [[NSMutableDictionary alloc] init];
    return _pageImageMasks;
}

- (NSMutableDictionary *)cgImageMasks
{
    if (nil != _cgImageMasks) {
        return _cgImageMasks;
    }
    
    _cgImageMasks = [[NSMutableDictionary alloc] init];
    return _cgImageMasks;
}

#pragma mark - UIAccessibility

- (void)setName:(NSString *)name forPage:(NSInteger)pageIndex {
    
    if (pageIndex < 0 || pageIndex >= self.numberOfPages) {
        return;
    }
    
    self.pageNames[@(pageIndex)] = name;
}

- (void)updateAccessibilityValue {
    
    NSString *pageName = [self nameForPage:self.currentPage];
    NSString *accessibilityValue = self.pageControl.accessibilityValue;
    
    if (pageName) {
        self.accessibilityValue = [NSString stringWithFormat:@"%@ - %@",pageName,accessibilityValue];
    } else {
        self.accessibilityValue = accessibilityValue;
    }
    
    
    
}


- (NSString *)nameForPage:(NSInteger)pageIndex {
    
    if (pageIndex < 0 || pageIndex >= self.numberOfPages) {
        return nil;
    }
    
    return self.pageNames[@(pageIndex)];
    
}



@end
