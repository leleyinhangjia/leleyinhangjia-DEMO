//
//  ZLyWebViewController.h
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/10.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLyWebViewController : UIViewController
- (instancetype)initWithUrlStr:(NSString *)url;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *titleString;
@end
