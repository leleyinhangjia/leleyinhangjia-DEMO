//
//  NewsViewController.h
//  36Ke
//
//  Created by lmj  on 16/3/3.
//  Copyright (c) 2016年 lmj . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController

@property (nonatomic, copy) NSString *urlString;
//@property (nonatomic)
- (instancetype)initColumn:(NSString *)column title:(NSString *)title;
@end
