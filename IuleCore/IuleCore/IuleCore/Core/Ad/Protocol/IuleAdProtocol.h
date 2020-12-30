//
//  IuleAdProtocol.h
//  IuleCore
//
//  Created by mac on 2019/12/20.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IuleAdConst.h"

@protocol IuleAdProtocol <NSObject>

@optional

/// 初始化平台
- (void)initAdPlatformWithAppId:(NSString *)appId;

/// 显示开屏广告
/// @param adInfo adInfo description
/// @param viewController viewController description
/// @param statusCallback statusCallback description
/// @param interactionCallback interactionCallback description
- (UIView *)showSplashAdWithAdInfo:(NSDictionary *)adInfo
                    viewController:(UIViewController *)viewController
                    statusCallback:(IuleSplashAdStatusCallBack)statusCallback
               interactionCallback:(IuleAdInteractionCallback)interactionCallback;

/// 加载激励视频广告
/// @param adInfo adInfo description
/// @param viewController viewController description
/// @param statusCallback statusCallback description
/// @param interactionCallback interactionCallback description
- (void)loadRewardVideoAdWithAdInfo:(NSDictionary *)adInfo
                     viewController:(UIViewController *)viewController
                     statusCallback:(IuleVideoAdStatusCallback)statusCallback
                interactionCallback:(IuleAdInteractionCallback)interactionCallback;

/// 显示激励视频广告
/// @param adInfo adInfo description
- (void)showRewardVideoAdWithAdInfo:(NSDictionary *)adInfo;

/// 显示banner广告
/// @param adInfo adInfo description
/// @param viewController viewController description
/// @param statusCallback statusCallback description
/// @param interactionCallback interactionCallback description
- (UIView *)loadBannerAdWithAdInfo:(NSDictionary *)adInfo
                    viewController:(UIViewController *)viewController
                   statusCallback:(IuleBannerAdStatusCallBack)statusCallback
              interactionCallback:(IuleAdInteractionCallback)interactionCallback;

/// 销毁banner广告
/// @param adInfo adInfo description
- (void)destroyBannerAdWithAdInfo:(NSDictionary *)adInfo;

/// 加载插屏广告
/// @param adInfo adInfo description
/// @param viewController viewController description
/// @param statusCallback statusCallback description
/// @param interactionCallback interactionCallback description
- (void)loadInterstitialAdWithAdInfo:(NSDictionary *)adInfo
                      viewController:(UIViewController *)viewController
                     statusCallback:(IuleInterstitialAdStatusCallBack)statusCallback
                interactionCallback:(IuleAdInteractionCallback)interactionCallback;

/// 显示插屏广告
/// @param adInfo adInfo description
- (void)showInterstitialAdWithAdInfo:(NSDictionary *)adInfo;

/// 展示信息流广告
/// @param adInfo adInfo description
/// @param viewController viewController description
/// @param statusCallback statusCallback description
/// @param interactionCallback interactionCallback description
- (void)loadNativeAdViewWithAdInfo:(NSDictionary *)adInfo
                    viewController:(UIViewController *)viewController
                    statusCallback:(IuleExpressAdStatusCallBack)statusCallback
               interactionCallback:(IuleAdInteractionCallback)interactionCallback;

/// 获取信息流广告View
- (NSArray *)getNativeAdViewsWithAdInfo:(NSDictionary *)adInfo;

@end
