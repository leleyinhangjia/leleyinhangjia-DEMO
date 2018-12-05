//
//  LMPageControl.h
//  36Ke
//
//  Created by lmj  on 16/3/2.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LMPageControlAlignment) {
    LMPageControlAlignmentLeft = 1,
    LMPageControlAlignmentCenter,
    LMPageControlAlignmentRight
};

typedef NS_ENUM(NSUInteger, LMPageControlVerticalAlignment) {
    LMPageControlVerticalAlignmentTop = 1,
    LMPageControlVerticalAlignmentMiddle,
    LMPageControlVerticalAlignmentBottom
};

typedef NS_ENUM(NSUInteger, LMPageControlTapBehavior) {
    LMPageControlTapBehaviorStep = 1,
    LMPageControlTapBehaviorJump
};

@interface LMPageControl : UIControl

/**
 *  页面索引数量
 */
@property (nonatomic, assign) NSInteger numberOfPages;

/**
 *  当前页面索引
 */
@property (nonatomic, assign) NSInteger currentPage;

/** 指示边距
 *  默认是10    1
 */
@property (nonatomic, assign) CGFloat indicatorMargin;

/** 指示直径
 *  默认是6       1
 */
@property (nonatomic, assign) CGFloat indicatorDiameter;

/**
 *  默认是36，不能小于indicatorDiameter值    1
 */
@property (nonatomic, assign) CGFloat minHeight;

/** 水平对齐
 *  默认为中心对齐
 */
@property (nonatomic, assign) LMPageControlAlignment alignment;

/** 垂直对齐
 *  默认为中间
 */
@property (nonatomic, assign) LMPageControlVerticalAlignment verticalAlignment;

/**
 * 页面索引指示图片
 */
@property (nonatomic, strong) UIImage *pageIndicatorImage;

/**
 *  页面指示遮盖图片（当前被选中的索引）
 */
@property (nonatomic, strong) UIImage *pageIndicatorMaskImage;

/**
 *  其他页面小点指示器颜色，如果pageindicatorimage设置忽略
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

/**
 *  当前页面索引指示图片，如果pageindicatorimage设置忽略
 */
@property (nonatomic, strong) UIImage *currentPageIndicatorImage;

/**
 *  当前页面索引指示颜色，如果currentpageindicatorimage设置忽略
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;


/**
 * 
 @private
 
 struct {
 unsigned int hideForSinglePage:1;
 unsigned int defersCurrentPageDisplay:1;
 } _pageControlFlags;
 */

/**
 *  如果只有一个页面，隐藏该指标。默认值是没有
 */
@property (nonatomic, assign) BOOL hidesForSinglePage;

/** 推迟当前页面显示
 *  如果设置，点击新页面不会更新当前显示页直到updatecurrentpagedisplay叫做。默认值是没有
 */
@property (nonatomic, assign) BOOL defersCurrentPageDisplay;

/**
 *  smpagecontroltapbehaviorstep提供递增/递减就像uipagecontrol行为。
 *  smpagecontroltapbehaviorjump允许特定的页面是利用各自的指标选择。默认
    smpagecontroltapbehaviorstep
 */
@property (nonatomic, assign) LMPageControlTapBehavior tapBehavior;

/**
 *  更新页面显示匹配的currentpage。如果deferscurrentpagedisplay是编号设置页面价值直接将立即更新忽略
 */
- (void)updateCurrentPageDisplay;

- (CGRect)rectForPageIndicator:(NSInteger)pageIndex;
/**
 *  返回给定的页计数的显示点所需的最小大小。如果页面计数可以改变，可以使用大小控制
 */
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

- (void)setImage:(UIImage *)image forPage:(NSInteger)pageIndex;

- (void)setCurrentImage:(UIImage *)image forPage:(NSInteger)pageIndex;

- (void)setImageMask:(UIImage *)image forPage:(NSInteger)pageIndex;

- (UIImage *)imageForPage:(NSInteger)pageIndex;
- (UIImage *)currentImageForPage:(NSInteger)pageIndex;
- (UIImage *)imageMaskForPage:(NSInteger)pageIndex;

- (void)updatePageNumberForScrollView:(UIScrollView *)scrollView;
- (void)setScrollViewContentOffsetForCurrentPage:(UIScrollView *)scrollView animated:(BOOL)animated;

/**
 *  LMPageControl默认反映UIPageControl标准的辅助功能。
 *  基本上，无障碍标签设置以“[当前页索引+1] [页数]”。
 *  LMPageControl允许你命名特定页面扩展UIPageControl功能。使用时，这是特别有用
 *  在每个页面指示图像，并允许您提供更多的上下文给用户。
 */
- (void)setName:(NSString *)name forPage:(NSInteger)pageIndex;
- (NSString *)nameForPage:(NSInteger)pageIndex;

///**
// *  其他的小点图片
// */
//@property (nonatomic, strong) UIImage *imagePageStateNormal;
//
///**
// *  当前小点图片
// */
//@property (nonatomic, strong) UIImage *imagePageStateHighlighed;

@end
