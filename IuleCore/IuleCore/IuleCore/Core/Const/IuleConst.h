//
//  IuleConst.h
//  Pods
//
//  Created by mac on 2020/5/18.
//

#ifndef IuleConst_h
#define IuleConst_h

#define IDFA [[[UIDevice currentDevice] identifierForVendor] UUIDString]

#define kIuleScreenSize [UIScreen mainScreen].bounds.size
#define kIuleScreenW    [UIScreen mainScreen].bounds.size.width
#define kIuleScreenH    [UIScreen mainScreen].bounds.size.height

#define kIuleIs_iphone ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
#define kIuleIs_iPhoneX (([UIScreen mainScreen].bounds.size.width >=375.0f && kIuleScreenH >=812.0f) || ([UIScreen mainScreen].bounds.size.width >=812.0f && kIuleScreenH >=375.0f))&& kIuleIs_iphone

/*状态栏高度*/
#define kIuleStatusBarH (CGFloat)(kIuleIs_iPhoneX?(44.0):(20.0))
/*导航栏高度*/
#define kIuleNavBarH (44)
/*状态栏和导航栏总高度*/
#define kIuleNavH (CGFloat)(kIuleIs_iPhoneX?(88.0):(64.0))
/*TabBar高度*/
#define kIuleTabBarH (CGFloat)(kIuleIs_iPhoneX?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define kIuleTopSafeH (CGFloat)(kIuleIs_iPhoneX?(44.0):(0))
/*底部安全区域远离高度*/
#define kIuleBottomSafeH (CGFloat)(kIuleIs_iPhoneX?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define kIuleTopBarDifH (CGFloat)(kIuleIs_iPhoneX?(24.0):(0))
/*导航条和Tabbar总高度*/
#define kIuleNavAndTabH (kIuleNavH + kIuleTabBarH)

#define kIuleLineH (1.0 / [UIScreen mainScreen].scale)

#define IuleWeakSelf        __weak typeof(self) weakSelf = self;
#define IuleStrongSelf      __strong typeof(weakSelf) strongSelf = weakSelf;

#define IuleRGB(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define IuleRGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define IuleColor(_color_) [UIColor ly_colorWithHexString:_color_]
#define IuleImage(_image_)  [UIImage imageNamed:_image_]

#define Iule_ACCESS_TOKEN @"IuleToken"

#ifdef DEBUG  //调试阶段

#define IuleLog(...)  NSLog(__VA_ARGS__);

#else //发布阶段

#define IuleLog(...)

#endif

#endif /* IuleConst_h */
