//
//  IuleTaskModuleProtocol.h
//  IuleCore
//
//  Created by wy on 2020/6/23.
//  Copyright © 2020 iule. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol IuleTaskModuleProtocol <NSObject>

@optional

- (void)openTaskVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;
- (void)openCoinBalanceVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

@end
