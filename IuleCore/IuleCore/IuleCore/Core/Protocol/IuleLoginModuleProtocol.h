//
//  IuleLoginModuleProtocol.h
//  Pods
//
//  Created by mac on 2020/5/18.
//

#import <UIKit/UIKit.h>

@protocol IuleLoginModuleProtocol <NSObject>

@optional

- (void)openLoginVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;
- (void)openPhoneLoginVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;
- (void)openBindPhoneVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;
- (void)openUserTicketVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;
- (void)openUserOrderVC:(NSDictionary *)params completeHandler:(void(^)(NSString *goodsId))completeHandler;

@end
