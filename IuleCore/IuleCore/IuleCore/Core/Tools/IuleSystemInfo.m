//
//  IuleSystemInfo.m
//  AFNetworking
//
//  Created by wangyang on 2020/2/3.
//

#import "IuleSystemInfo.h"
#import <objc/runtime.h>
#import <sys/utsname.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <AdSupport/AdSupport.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation IuleSystemInfo

+ (IuleSystemInfo *)systemInfo {
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *language = infoDict[@"CFBundleDevelopmentRegion"];
    NSString *version = infoDict[@"CFBundleShortVersionString"];
    NSString *system = [NSString stringWithFormat:@"%@ %@",[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
    CGRect bounds = [UIScreen mainScreen].bounds;
    IuleSystemInfo *systemInfo = [[IuleSystemInfo alloc] init];
    systemInfo.brand = [systemInfo iphoneType];
    systemInfo.model = [systemInfo iphoneType];
    systemInfo.language = language;
    systemInfo.version = version;
    systemInfo.system = system;
    systemInfo.platform = @"iOS";
    systemInfo.SDKVersion = @"1.0.0";
    systemInfo.pixelRatio = [UIScreen mainScreen].scale;
    systemInfo.screenWidth = bounds.size.width;
    systemInfo.screenHeight = bounds.size.height;
    systemInfo.windowWidth = bounds.size.width;
    systemInfo.windowHeight = bounds.size.height;
    systemInfo.statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    systemInfo.fontSizeSetting = 14.0;
    return systemInfo;
}

+ (NSDictionary *)systemInfoKeyValues {
    return [[IuleSystemInfo systemInfo] keyValues];
}

///model转化为字典
- (NSDictionary *)keyValues {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        ///valueForKey返回的数字和字符串都是对象
        NSObject *value = [self valueForKey:name];
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            //string , bool, int ,NSinteger
            [dic setObject:value forKey:name];
        }
    }
    return [dic copy];
}

- (NSString *)iphoneType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    NSDictionary *iphoneTypeMap = @{@"iPhone1,1":@"iPhone 2G",
                                    @"iPhone1,2":@"iPhone 3G",
                                    @"iPhone2,1":@"iPhone 3GS",
                                    @"iPhone3,1":@"iPhone 4",
                                    @"iPhone3,2":@"iPhone 4",
                                    @"iPhone3,3":@"iPhone 4",
                                    @"iPhone4,1":@"iPhone 4S",
                                    @"iPhone5,1":@"iPhone 5",
                                    @"iPhone5,2":@"iPhone 5",
                                    @"iPhone5,3":@"iPhone 5c",
                                    @"iPhone5,4":@"iPhone 5c",
                                    @"iPhone6,1":@"iPhone 5s",
                                    @"iPhone6,2":@"iPhone 5s",
                                    @"iPhone7,1":@"iPhone 6 Plus",
                                    @"iPhone7,2":@"iPhone 6",
                                    @"iPhone8,1":@"iPhone 6s",
                                    @"iPhone8,2":@"iPhone 6s Plus",
                                    @"iPhone8,4":@"iPhone SE",
                                    @"iPhone9,1":@"iPhone 7",
                                    @"iPhone9,2":@"iPhone 7 Plus",
                                    @"iPhone9,3":@"iPhone 7",
                                    @"iPhone9,4":@"iPhone 7 Plus",
                                    @"iPhone10,1":@"iPhone 8",
                                    @"iPhone10,2":@"iPhone 8 Plus",
                                    @"iPhone10,3":@"iPhone X",
                                    @"iPhone10,4":@"iPhone 8",
                                    @"iPhone10,5":@"iPhone 8 Plus",
                                    @"iPhone10,6":@"iPhone X",
                                    @"iPhone11,2":@"iPhone XS",
                                    @"iPhone11,4":@"iPhone XS Max",
                                    @"iPhone11,6":@"iPhone XS Max",
                                    @"iPhone11,8":@"iPhone XR",
                                    @"iPhone12,1":@"iPhone 11",
                                    @"iPhone12,3":@"iPhone 11 Pro",
                                    @"iPhone12,5":@"iPhone 11 Pro Max",
                                    @"iPod1,1":@"iPod Touch 1G",
                                    @"iPod2,1":@"iPod Touch 2G",
                                    @"iPod3,1":@"iPod Touch 3G",
                                    @"iPod4,1":@"iPod Touch 4G",
                                    @"iPod5,1":@"iPod Touch 5G",
                                    @"iPad1,1":@"iPad 1G",
                                    @"iPad2,1":@"iPad 2 (WiFi)",
                                    @"iPad2,2":@"iPad 2",
                                    @"iPad2,3":@"iPad 2 (CDMA)",
                                    @"iPad2,4":@"iPad 2",
                                    @"iPad2,5":@"iPad Mini (WiFi)",
                                    @"iPad2,6":@"iPad Mini",
                                    @"iPad2,7":@"iPad Mini (GSM+CDMA)",
                                    @"iPad3,1":@"iPad 3 (WiFi)",
                                    @"iPad3,2":@"iPad 3 (GSM+CDMA)",
                                    @"iPad3,3":@"iPad 3",
                                    @"iPad3,4":@"iPad 4 (WiFi)",
                                    @"iPad3,5":@"iPad 4",
                                    @"iPad3,6":@"iPad 4 (GSM+CDMA)",
                                    @"iPad4,1":@"iPad Air (WiFi)",
                                    @"iPad4,2":@"iPad Air (Cellular)",
                                    @"iPad4,3":@"iPad Air",
                                    @"iPad4,4":@"iPad Mini 2 (WiFi)",
                                    @"iPad4,5":@"iPad Mini 2 (Cellular)",
                                    @"iPad4,6":@"iPad Mini 2",
                                    @"iPad4,7":@"iPad Mini 3",
                                    @"iPad4,8":@"iPad Mini 3",
                                    @"iPad4,9":@"iPad Mini 3",
                                    @"iPad5,1":@"iPad Mini 4 (WiFi)",
                                    @"iPad5,2":@"iPad Mini 4 (LTE)",
                                    @"iPad5,3":@"iPad Air 2",
                                    @"iPad5,4":@"iPad Air 2",
                                    @"iPad6,3":@"iPad Pro 9.7",
                                    @"iPad6,4":@"iPad Pro 9.7",
                                    @"iPad6,7":@"iPad Pro 12.9",
                                    @"iPad6,8":@"iPad Pro 12.9",
                                    @"iPad6,11":@"iPad 5 (WiFi)",
                                    @"iPad6,12":@"iPad 5 (Cellular)",
                                    @"iPad7,1":@"iPad Pro 12.9 inch 2nd gen (WiFi)",
                                    @"iPad7,2":@"iPad Pro 12.9 inch 2nd gen (Cellular)",
                                    @"iPad7,3":@"iPad Pro 10.5 inch (WiFi)",
                                    @"iPad7,4":@"iPad Pro 10.5 inch (Cellular)",
                                    @"AppleTV2,1":@"Apple TV 2",
                                    @"AppleTV3,1":@"Apple TV 3",
                                    @"AppleTV3,2":@"Apple TV 3",
                                    @"AppleTV5,3":@"Apple TV 4",
                                    @"i386":@"iPhone Simulator",
                                    @"x86_64":@"iPhone Simulator"};
    NSString *deviceType = iphoneTypeMap[platform];
    if (!deviceType) {
        deviceType = @"iOS Device";
    }
    return deviceType;
}

/// 获取设备唯一标识
+ (NSString *)getDeviceId {
    NSString *deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if ([deviceId isEqualToString:@"00000000-0000-0000-0000-000000000000"]) {
        deviceId = @"";
    }
    return deviceId;
}

/// 获取设备唯一标识
+ (NSString *)getChannel {
    return @"appstore";
}

/// 获取运营商信息
+ (NSString *)getCarrier {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mcc = [carrier mobileCountryCode]; // 国家码 如：460
    NSString *mnc = [carrier mobileNetworkCode]; // 网络码 如：01
    NSString *name = [carrier carrierName]; // 运营商名称，中国联通
    NSString *isoCountryCode = [carrier isoCountryCode]; // cn
    BOOL allowsVOIP = [carrier allowsVOIP];// YES
    NSString *radioAccessTechnology = info.currentRadioAccessTechnology; // 无线连接技术，如CTRadioAccessTechnologyLTE
    return name;
}

/// 获取mac地址
+ (NSString *)getMacAddress {
    NSString *ssid = @"Not Found";
    NSString *macIp = @"Not Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray,0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            ssid = [dict valueForKey:@"SSID"];
            macIp = [dict valueForKey:@"BSSID"];
        }
    }
    return macIp;
}

/// 获取电量
+ (NSString *)getBattery {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    CGFloat battery = [UIDevice currentDevice].batteryLevel;
    return [NSString stringWithFormat:@"%.f",battery * 100];
}

/// 获取分辨率
+ (NSString *)getResolution {
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGFloat scale = [UIScreen mainScreen].scale;
    return [NSString stringWithFormat:@"%.f * %.f",bounds.size.width * scale, bounds.size.height * scale];
}

/// 获取系统版本号
+ (NSString *)getSystemVersion {
    return [UIDevice currentDevice].systemVersion;
}

/// 获取本地语言
+ (NSString *)getLocalLanguage {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    return preferredLang;
}

/// 获取设备品牌
+ (NSString *)getDeviceBrand {
    return [IuleSystemInfo systemInfo].brand;
}

/// 获取电话号码
+ (NSString *)getPhoneNumber {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"SBFormattedPhoneNumber"];
}

/// 获取SIM卡信息
+ (NSString *)getSIMInfo {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *simInfo = [NSString stringWithFormat:@"%@&%@&%@&%@",carrier.carrierName,carrier.mobileCountryCode,carrier.mobileNetworkCode,carrier.isoCountryCode];
    return simInfo;
}

@end
