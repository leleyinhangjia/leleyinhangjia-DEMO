//
//  ZLyWebViewController.h
//  MiaoBo
//
//  Created by mpgy on 2017/3/10.
//  Copyright © 2017年 com.mpgy.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLyWebViewController : UIViewController
- (instancetype)initWithUrlStr:(NSString *)url;
@property (nonatomic,copy) NSString *url;
@end
