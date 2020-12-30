//
//  IuleDevAppModuleProtocol.h
//  Pods
//
//  Created by wy on 2020/6/13.
//
#import <UIKit/UIKit.h>

@protocol IuleDevAppModuleProtocol <NSObject>

@optional

/// 商品详情页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openGoodsDetail:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 订单页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openOrderTaskVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

/// 填写订单页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openFillOrderVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

/// 填写订单结果页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openFillOrderResultVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

/// 订单申请页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openOrderApplyResultVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

/// 订单申请成功页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openOrderApplySuccessVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

@end
