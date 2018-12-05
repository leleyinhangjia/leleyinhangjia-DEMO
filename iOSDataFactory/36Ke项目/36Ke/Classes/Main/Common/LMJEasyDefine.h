//
//  LMJEasyDefine.h
//  LMJNews
//
//  Created by lmj on 16/1/2.
//  Copyright © 2016年 lmj. All rights reserved.
//

#ifndef LMJEasyDefine_h
#define LMJEasyDefine_h


/** 字体*/
#define LMJFont(x) [UIFont systemFontOfSize:x]
#define LMJBoldFont(x) [UIFont boldSystemFontOfSize:x]

/** 颜色*/
#define LMJRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define LMJRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define LMJRGB16Color(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/** 导航栏标题字体大小*/
#define LMJNavigationFont [UIFont boldSystemFontOfSize:16]

/** 公用颜色*/
#define LMJCommonColor [UIColor colorWithRed:0.478 green:0.478 blue:0.478 alpha:1]

/** 全局的绿色主题*/
#define LMJGolbalGreen LMJRGBColor(33, 197, 180)


/** 输出*/
#ifdef DEBUG
#define LMJLog(...) NSLog(__VA_ARGS__)
#else
#define LMJLog(...)
#endif

/** 获取硬件信息*/
#define LMJSCREEN_W [UIScreen mainScreen].bounds.size.width
#define LMJSCREEN_H [UIScreen mainScreen].bounds.size.height
#define LMJCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define LMJCurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

/** 抽屉*/
// 抽屉顶部距离 底部一样
#define LMJScaleTopMargin 35
//抽屉拉出来右边剩余比例
#define LMJZoomScaleRight 0.14

//推荐cell的高度
#define LMJRnmdCellHeight 210.0
//推荐headView的高度
#define LMJRnmdHeadViewHeight 60.0
//背景的灰色
#define LMJBackgroundGrayColor LMJRGBColor(51, 52, 53)


/** 适配*/
#define LMJiOS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define LMJiOS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define LMJiOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define LMJiOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define LMJiOS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

#define LMJiPhone4_OR_4s    (LMJSCREEN_H == 480)
#define LMJiPhone5_OR_5c_OR_5s   (LMJSCREEN_H == 568)
#define LMJiPhone6_OR_6s   (LMJSCREEN_H == 667)
#define LMJiPhone6Plus_OR_6sPlus   (LMJSCREEN_H == 736)
#define LMJiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 弱指针*/
#define LMJWeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;

/** 加载本地文件*/
#define LMJLoadImage(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define LMJLoadArray(file,type) [UIImage arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define LMJLoadDict(file,type) [UIImage dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]

/** 多线程GCD*/
#define LMJGlobalGCD(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define LMJMainGCD(block) dispatch_async(dispatch_get_main_queue(),block)

/** 数据存储*/
#define LMJUserDefaults [NSUserDefaults standardUserDefaults]
#define LMJCacheDir [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define LMJDocumentDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define LMJTempDir NSTemporaryDirectory()
#endif /* LMJEasyDefine_h */
