//
//  IuleBaseAdManager.m
//  IuleTouTiaoAD
//
//  Created by mac on 2019/12/21.
//  Copyright © 2019 iule. All rights reserved.
//

#import "IuleBaseAdManager.h"

@implementation IuleBaseAdManager

- (instancetype)initAdManagerWithDelegate:(id <IulePlatformAdDelegate>)delegate viewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        self.adDelegate = delegate;
        self.viewController = viewController;
    }
    return self;
}

- (void)setAdMangerInfo:(IuleAdInfoModel *)adInfo {
    self.adSceneType = adInfo.adScene;
    self.codeId = adInfo.codeId;
    self.appId = adInfo.appId;
    self.adSize = CGSizeMake(adInfo.realWidth, adInfo.realHeight);
    self.adCount = adInfo.count;
}

@end
