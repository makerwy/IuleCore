//
//  IulePlatformAdDelegate.h
//  IuleCore
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 iule. All rights reserved.
//

@class IuleBaseAdManager;

@protocol IulePlatformAdDelegate <NSObject>

@optional

- (void)adDidLoad:(IuleBaseAdManager *_Nullable)adManager;
- (void)adManager:(IuleBaseAdManager *_Nullable)adManager didFailWithError:(NSError * _Nullable)error;
- (void)adDidExposure:(IuleBaseAdManager *_Nullable)adManager;
- (void)adDidClick:(IuleBaseAdManager *_Nullable)adManager;
- (void)adDidClose:(IuleBaseAdManager *_Nullable)adManager;
- (void)adDidClickSkip:(IuleBaseAdManager *_Nullable)adManager;

@end
