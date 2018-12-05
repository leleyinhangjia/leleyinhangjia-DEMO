//
//  ViewController.h
//  PayDemo
//
//  Created by Chris Beauchamp on 10/7/14.
//  Copyright (c) 2014 Crittercism. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <PassKit/PassKit.h>

@interface ViewController : UIViewController
<PKPaymentAuthorizationViewControllerDelegate>

- (IBAction)checkOut:(id)sender;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com