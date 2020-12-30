//
//  IuleLeaderModuleProtocol.h
//  Pods
//
//  Created by mac on 2020/5/19.
//
#import <UIKit/UIKit.h>

@protocol IuleLeaderModuleProtocol <NSObject>

@optional

- (void)openLeaderVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;
- (void)openSplashVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;
- (void)initRootController:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

@end
