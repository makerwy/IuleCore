//
//  IuleAdConst.h
//  IuleCore
//
//  Created by wy on 2020/6/12.
//  Copyright © 2020 iule. All rights reserved.
//

#ifndef IuleAdConst_h
#define IuleAdConst_h

typedef enum : NSUInteger {
    IuleAdShowPositionTop = 0,
    IuleAdShowPositionCenter,
    IuleAdShowPositionBottom,
} IuleAdShowPositionType;//广告展示位置

typedef enum : NSUInteger {
    /**加载视频广告成功*/
    IULE_VIDEO_AD_STATUS_LOADED = 0,
    /**加载视频广告失败*/
    IULE_VIDEO_AD_STATUS_FAILED,
    /**加载视频广告失败 超过当日最大次数*/
    IULE_VIDEO_AD_STATUS_FAILED_MAXCOUNT,
    /** 视频广告已显示 */
    IULE_VIDEO_AD_STATUS_EXPOSED,
    /**关闭视频广告*/
    IULE_VIDEO_AD_STATUS_CLOSED,
    /**有效*/
    IULE_VIDEO_AD_STATUS_AVAILABLE,
    /**无效*/
    IULE_VIDEO_AD_STATUS_NO_AVAILABLE,
} IuleVideoAdStatus;

typedef enum : NSUInteger {
    /**加载Splash广告成功*/
    IULE_SPLASH_AD_STATUS_LOADED = 0,
    /**加载Splash广告失败*/
    IULE_SPLASH_AD_STATUS_FAILED,
    /**Splash广告已显示*/
    IULE_SPLASH_AD_STATUS_EXPOSED,
    /**关闭Splash广告*/
    IULE_SPLASH_AD_STATUS_CLOSED
} IuleSplashAdStatus;

typedef enum : NSUInteger {
    /**加载Express广告成功*/
    IULE_EXPRESS_AD_STATUS_LOADED = 0,
    /**加载Express广告失败*/
    IULE_EXPRESS_AD_STATUS_FAILED,
    /**Express广告已显示*/
    IULE_EXPRESS_AD_STATUS_EXPOSED,
    /**关闭Express广告*/
    IULE_EXPRESS_AD_STATUS_CLOSED
} IuleExpressAdStatus;

typedef enum : NSUInteger {
    /**加载banner广告成功*/
    IULE_BANNER_AD_STATUS_LOADED = 0,
    /**加载banner广告失败*/
    IULE_BANNER_AD_STATUS_FAILED,
    /**banner广告已显示*/
    IULE_BANNER_AD_STATUS_EXPOSED,
    /**关闭banner广告*/
    IULE_BANNER_AD_STATUS_CLOSED
} IuleBannerAdStatus;

typedef enum : NSUInteger {
    /**加载插屏广告成功*/
    IULE_INTERSTITIAL_AD_STATUS_LOADED = 0,
    /**加载插屏广告失败*/
    IULE_INTERSTITIAL_AD_STATUS_FAILED,
    /** 插屏广告已显示 */
    IULE_INTERSTITIAL_AD_STATUS_EXPOSED,
    /**关闭插屏广告*/
    IULE_INTERSTITIAL_AD_STATUS_CLOSED,
    /**有效*/
    IULE_INTERSTITIAL_AD_STATUS_AVAILABLE,
    /**无效*/
    IULE_INTERSTITIAL_AD_STATUS_NO_AVAILABLE,
} IuleInterstitialAdStatus;

/** 用户交互操作 */
typedef NS_ENUM(NSInteger, IuleAdInteractionType) {
    IULE_AD_CLICK = 1,
    IULE_AD_CLICK_EXT_BUTTON = 2, // 仅视频广告有该按钮
    IULE_AD_CLICK_LAND_PAGE = 3, // 仅视频广告有落地页
};

// callback to get ad interaction
typedef void (^IuleAdInteractionCallback)(IuleAdInteractionType act);

//callback to get splash ad status
typedef void (^IuleSplashAdStatusCallBack)(IuleSplashAdStatus status);

//callback to get express ad status
typedef void (^IuleExpressAdStatusCallBack)(IuleExpressAdStatus status);

// callback to get video ad status
typedef void (^IuleVideoAdStatusCallback)(IuleVideoAdStatus status, NSString *orderNum);

//callback to get banner ad status
typedef void (^IuleBannerAdStatusCallBack)(IuleBannerAdStatus status);

//callback to get banner ad status
typedef void (^IuleInterstitialAdStatusCallBack)(IuleInterstitialAdStatus status);

#endif /* IuleAdConst_h */
