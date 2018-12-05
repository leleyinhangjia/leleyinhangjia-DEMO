//
//  TheSecondViewController.m
//  MoveCollectionView
//
//  Created by apple on 15/8/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "TheSecondViewController.h"
#import "AppDelegate.h"
@interface TheSecondViewController ()
{
    CGFloat ridus;
}
@property(nonatomic,retain)UIImageView *imageView;
@end

@implementation TheSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ridus = 50;
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,200)];
    image.backgroundColor = [UIColor lightGrayColor];
    image.image = [UIImage imageNamed:@"2.jpg"];
    [self.view addSubview:image];
    _imageView =[[UIImageView alloc]init];
    _imageView.center = CGPointMake(70, 200);
    _imageView.bounds = CGRectMake(0, 0, 100, 100);
    _imageView.image = self.img;
    [self.view addSubview:_imageView];
    
    
//    CAShapeLayer*  shapeLayer = [[CAShapeLayer alloc] init];
//    [shapeLayer setFrame:self.view.bounds];
//    
//    CGMutablePathRef path =CGPathCreateMutable();
//    CGPathAddArc(path, NULL,_imageView.center.x,_imageView.center.y, ridus, 0, 2*M_PI, NO);
//    [shapeLayer setPath:path];
//    
//    [self.view.layer setMask:shapeLayer];
    //[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(expandRidus:) userInfo:nil repeats:YES];
     
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(0 ,100 ,100 ,50);
    [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    [self expandCoop];
    
}



//放大的圈圈
-(void)expandCoop
{
    CGRect rect = CGRectInset(_imageView.frame, -600, -600);
    
    CGPathRef startPath = CGPathCreateWithEllipseInRect(rect, NULL);
    CGPathRef endPath   = CGPathCreateWithEllipseInRect(_imageView.frame, NULL);
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = startPath;
    
    self.view.layer.mask = maskLayer;
    
    CABasicAnimation *pingAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    
    pingAnimation.fromValue = (__bridge id)(endPath);
    pingAnimation.toValue   = (__bridge id)(startPath);
    pingAnimation.duration  = 1;
    pingAnimation.delegate = self;
    [pingAnimation setValue:@"animate1" forKey:@"animate1"];
    pingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayer addAnimation:pingAnimation forKey:@"pingInvert1"];
    
    CGPathRelease(startPath);
    CGPathRelease(endPath);
//    [self performSelector:@selector(removeImage) withObject:nil afterDelay:2];
    
}
/*
//缩小的圈圈*/
-(void)scalaCoop
{
    CGRect rect = CGRectInset(_imageView.frame, -600, -600);
    
    CGPathRef startPath = CGPathCreateWithEllipseInRect(rect, NULL);
    CGPathRef endPath   = CGPathCreateWithEllipseInRect(_imageView.frame, NULL);
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = endPath;
    
    self.view.layer.mask = maskLayer;
    
    CABasicAnimation *pingAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pingAnimation.delegate = self;
    [pingAnimation setValue:@"animate2" forKey:@"animate2"];

    pingAnimation.fromValue = (__bridge id)(startPath);
    pingAnimation.toValue   = (__bridge id)(endPath);
    pingAnimation.duration  = 1;
    
    pingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayer addAnimation:pingAnimation forKey:@"pingInvert2"];
    
    CGPathRelease(startPath);
    CGPathRelease(endPath);
    //[self performSelector:@selector(animation) withObject:nil afterDelay:2];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if ([[anim valueForKey:@"animate1"] isEqualToString:@"animate1"]) {
        
         [self removeImage];
        
    }else if([[anim valueForKey:@"animate2"] isEqualToString:@"animate2"])
    {
        [self animation];
    }
    
    
    
//    if (anim == [self.view.layer.mask animationForKey:@"pingInvert1"]) {
//        [self removeImage];
//        
//    }else if (anim == [self.view.layer.mask animationForKey:@"pingInvert2"])
//    {
//        [self animation];
//    }
}


-(void)removeImage
{
    AppDelegate *appdele = [UIApplication sharedApplication].delegate;
    [appdele.img removeFromSuperview];

}
-(void)addImage
{
    AppDelegate *appdele = [UIApplication sharedApplication].delegate;
    [appdele.window addSubview:appdele.img];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    imgView.image = appdele.img.image;
    imgView.backgroundColor = [UIColor lightGrayColor];
//    [appdele.window addSubview:imgView];

}

-(void)goBack:(UIButton *)sender
{
    sender.enabled = NO;
    [self addImage];
    [self scalaCoop];
//    AppDelegate *appdele = [UIApplication sharedApplication].delegate;
//    [appdele.window addSubview:appdele.img];
    //[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(scalaRidus:) userInfo:nil repeats:YES];
}


//-(void)scalaRidus:(NSTimer *)timer
//{
//    if (ridus<=30) {
//        [timer invalidate];
//        [self animation];
//    }
//    ridus = ridus-10;
//    CAShapeLayer*  shapeLayer = [[CAShapeLayer alloc] init];
//    [shapeLayer setFrame:self.view.bounds];
//    
//    CGMutablePathRef path =CGPathCreateMutable();
//    CGPathAddArc(path, NULL,_imageView.center.x,_imageView.center.y, ridus, 0, 2*M_PI, NO);
//    [shapeLayer setPath:path];
//    [self.view.layer setMask:shapeLayer];
//}
//
//
//
//
//
//-(void)expandRidus:(NSTimer *)timer
//{
//    if (ridus >= 600) {
//        [timer invalidate];
//        
//    }else if(ridus >60)
//    {
//        AppDelegate *appdele = [UIApplication sharedApplication].delegate;
//        [appdele.img removeFromSuperview];
//    }
//    ridus = ridus+10;
//    CAShapeLayer*  shapeLayer = [[CAShapeLayer alloc] init];
//    [shapeLayer setFrame:self.view.bounds];
//    
//    CGMutablePathRef path =CGPathCreateMutable();
//    CGPathAddArc(path, NULL,_imageView.center.x,_imageView.center.y, ridus, 0, 2*M_PI, NO);
//    [shapeLayer setPath:path];
//    
//    [self.view.layer setMask:shapeLayer];
//
//}

-(void)animation
{
    AppDelegate *appdele = [UIApplication sharedApplication].delegate;
    UIImageView *imageView = appdele.img;
    NSArray *vcArr = self.navigationController.viewControllers;
    UIViewController *vc = vcArr[vcArr.count-2];
    vc.view.alpha = 0;
    [appdele.window addSubview:vc.view];

    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
            imageView.bounds = CGRectMake(0, 0, 110, 110);
            imageView.layer.shadowOffset = CGSizeMake(4, 4);
            imageView.layer.shadowRadius = 30;
            imageView.layer.shadowColor = [UIColor blackColor].CGColor;
            imageView.layer.shadowOpacity = 0.9;
            imageView.center = appdele.pushCenter;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2 animations:^{
                imageView.bounds = CGRectMake(0,0, 100, 100);
                vc.view.alpha = 1;
                
            } completion:^(BOOL finished) {
                imageView.layer.shadowOffset = CGSizeMake(0, 0);
                imageView.layer.shadowRadius = 0;
                imageView.layer.shadowColor = [UIColor clearColor].CGColor;
                [appdele.img removeFromSuperview];
                [self performSelector:@selector(goToNextVc:) withObject:vc afterDelay:0.3];
            }];
        }];
    }];
}
-(void)goToNextVc:(UIViewController *)vc
{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)dealloc
{
    
}
@end
