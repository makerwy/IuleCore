//
//  IuleWebModuleProtocol.h
//  IuleCore
//
//  Created by wy on 2020/5/28.
//  Copyright © 2020 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IuleWebModuleProtocol <NSObject>

@optional

- (void)openCommonWebVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

- (void)openFeedbackWebVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

@end
