//
//  IuleSystemInfo.h
//  AFNetworking
//
//  Created by wangyang on 2020/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IuleSystemInfo : NSObject
@property (nonatomic, copy) NSString *brand;//设备品牌
@property (nonatomic, copy) NSString *model;//设备型号
@property (nonatomic, copy) NSString *language;//设置的语言
@property (nonatomic, copy) NSString *version;//版本号
@property (nonatomic, copy) NSString *system;//操作系统及版本
@property (nonatomic, copy) NSString *platform;//客户端平台
@property (nonatomic, copy) NSString *SDKVersion;//客户端基础库版本
@property (nonatomic, assign) CGFloat pixelRatio;//设备像素比
@property (nonatomic, assign) CGFloat screenWidth;//屏幕宽度，单位px
@property (nonatomic, assign) CGFloat screenHeight;//屏幕高度，单位px
@property (nonatomic, assign) CGFloat windowWidth;//可使用窗口宽度，单位px
@property (nonatomic, assign) CGFloat windowHeight;//可使用窗口高度，单位px
@property (nonatomic, assign) CGFloat statusBarHeight;//状态栏的高度，单位px
@property (nonatomic, assign) CGFloat fontSizeSetting;//用户字体大小（单位px）。以微信客户端「我-设置-通用-字体大小」中的设置为准
@property (nonatomic, assign) CGFloat benchmarkLevel;//设备性能等级（仅Android小游戏）。取值为：-2 或 0（该设备无法运行小游戏），-1（性能未知），>=1（设备性能值，该值越高，设备性能越好，目前最高不到50）

+ (IuleSystemInfo *)systemInfo;
+ (NSDictionary *)systemInfoKeyValues;

/// 获取设备唯一标识
+ (NSString *)getDeviceId;

/// 获取设备唯一标识
+ (NSString *)getChannel;

/// 获取运营商信息
+ (NSString *)getCarrier;

/// 获取mac地址
+ (NSString *)getMacAddress;

/// 获取电量
+ (NSString *)getBattery;

/// 获取分辨率
+ (NSString *)getResolution;

/// 获取系统版本号
+ (NSString *)getSystemVersion;

/// 获取本地语言
+ (NSString *)getLocalLanguage;

/// 获取设备品牌
+ (NSString *)getDeviceBrand;

/// 获取电话号码
+ (NSString *)getPhoneNumber;

/// 获取SIM卡信息
+ (NSString *)getSIMInfo;

@end

NS_ASSUME_NONNULL_END
