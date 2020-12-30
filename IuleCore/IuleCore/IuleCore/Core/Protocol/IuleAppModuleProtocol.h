//
//  IuleAppModuleProtocol.h
//  IuleCore
//
//  Created by mac on 2020/5/22.
//  Copyright © 2020 iule. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol IuleAppModuleProtocol <NSObject>

@optional

/// 现金余额页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openBalanceVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

/// 提现页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openDepositVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

/// 绑定银行卡
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openBindBankVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

/// 消息中心页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openMessageCenterVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

/// 新人免单
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openNewUserWelfare:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 商品详情页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openGoodsDetailVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 新人免费送详情页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openRecieveDetailVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

/// 免单详情页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openFreeDetail:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 试用详情页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openTryoutDetail:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 返利详情页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openRebateDetail:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

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

/// 填写0元体验订单结果页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openTryoutFillOrderResultVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

/// 订单申请页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openOrderApplyResultVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

/// 订单申请成功页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openOrderApplySuccessVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

/// 跳转到对应的订单列表（tabbar）
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openOrderList:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 跳转到订单详情
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openOrderDetailVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 跳转到订单详情
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openNewOrderDetailVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 跳转到邀请页面
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openInviteVC:(NSDictionary *)params completeHandler:(void(^)(BOOL success))completeHandler;

/// 跳转到免费领取成功页面
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openFreeRecieveVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 跳转到免费领取待发货页面
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openFreeRecieveResultVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 跳转到编辑地址页面
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openEditAddressVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 跳转到试用任务页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openTryoutTaskVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 跳转到试用申请结果页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openTryoutResultVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 跳转到试用申请成功
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openTryoutSuccessVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 试用申请失败页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openTryoutFailVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

/// 跳转到返利任务页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openRebateTaskVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 跳转到返利结果页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openRebateResultVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 跳转到个人信息页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openUserInfoVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 跳转到加入社群页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openJoinLhmVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 评价任务
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openEvaluateVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 评价任务结果页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openEvaluateResultVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 上传订单收货截图
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openUploadOrderPicVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

/// 上传订单收货截图结果页
/// @param params params description
/// @param completeHandler completeHandler description
- (void)openUploadOrderPicResultVC:(NSDictionary *)params completeHandler:(void(^)(void))completeHandler;

@end
