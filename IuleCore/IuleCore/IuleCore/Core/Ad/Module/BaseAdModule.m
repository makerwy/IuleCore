//
//  BaseAdModule.m
//  IuleCore
//
//  Created by wy on 2020/6/12.
//  Copyright © 2020 iule. All rights reserved.
//

#import "BaseAdModule.h"

@implementation BaseAdModule

#pragma mark -
#pragma mark - lazy

- (NSMutableDictionary *)adManagerDic {
    if (!_adManagerDic) {
        _adManagerDic = @{}.mutableCopy;
    }
    return _adManagerDic;
}

#pragma mark -
#pragma mark - IuleAdProtocol

/// 初始化平台
- (void)initAdPlatformWithAppId:(NSString *)appId {}

/// 显示开屏广告
/// @param adInfo adInfo description
/// @param viewController viewController description
/// @param statusCallback statusCallback description
/// @param interactionCallback interactionCallback description
- (UIView *)showSplashAdWithAdInfo:(NSDictionary *)adInfo
                    viewController:(UIViewController *)viewController
                    statusCallback:(IuleSplashAdStatusCallBack)statusCallback
               interactionCallback:(IuleAdInteractionCallback)interactionCallback {
    return nil;
}
/// 加载激励视频广告
/// @param adInfo adInfo description
/// @param viewController viewController description
/// @param statusCallback statusCallback description
/// @param interactionCallback interactionCallback description
- (void)loadRewardVideoAdWithAdInfo:(NSDictionary *)adInfo
                     viewController:(UIViewController *)viewController
                     statusCallback:(IuleVideoAdStatusCallback)statusCallback
                interactionCallback:(IuleAdInteractionCallback)interactionCallback {}

/// 显示激励视频广告
/// @param adInfo adInfo description
- (void)showRewardVideoAdWithAdInfo:(NSDictionary *)adInfo {}

/// 显示banner广告
/// @param adInfo adInfo description
/// @param viewController viewController description
/// @param statusCallback statusCallback description
/// @param interactionCallback interactionCallback description
- (UIView *)loadBannerAdWithAdInfo:(NSDictionary *)adInfo
                    viewController:(UIViewController *)viewController
                   statusCallback:(IuleBannerAdStatusCallBack)statusCallback
              interactionCallback:(IuleAdInteractionCallback)interactionCallback {
    return nil;
}

/// 销毁banner广告
/// @param adInfo adInfo description
- (void)destroyBannerAdWithAdInfo:(NSDictionary *)adInfo {}

/// 加载插屏广告
/// @param adInfo adInfo description
/// @param viewController viewController description
/// @param statusCallback statusCallback description
/// @param interactionCallback interactionCallback description
- (void)loadInterstitialAdWithAdInfo:(NSDictionary *)adInfo
                      viewController:(UIViewController *)viewController
                     statusCallback:(IuleInterstitialAdStatusCallBack)statusCallback
                interactionCallback:(IuleAdInteractionCallback)interactionCallback {}

/// 显示插屏广告
/// @param adInfo adInfo description
- (void)showInterstitialAdWithAdInfo:(NSDictionary *)adInfo {}

/// 展示信息流广告
/// @param adInfo adInfo description
/// @param viewController viewController description
/// @param statusCallback statusCallback description
/// @param interactionCallback interactionCallback description
- (void)loadNativeAdViewWithAdInfo:(NSDictionary *)adInfo
                    viewController:(UIViewController *)viewController
                    statusCallback:(IuleExpressAdStatusCallBack)statusCallback
               interactionCallback:(IuleAdInteractionCallback)interactionCallback {}

/// 获取信息流广告View
- (NSArray *)getNativeAdViewsWithAdInfo:(NSDictionary *)adInfo {return @[];}

@end
