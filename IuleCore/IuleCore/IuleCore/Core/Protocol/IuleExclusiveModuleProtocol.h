//
//  IuleExclusiveModuleProtocol.h
//  IuleCore
//
//  Created by wangyang on 2020/8/26.
//  Copyright © 2020 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IuleExclusiveModuleProtocol <NSObject>

@optional

- (void)openExclusiveCenterVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

- (void)openExclusiveListVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

- (void)openTicketListVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

- (void)openTicketGoodsListVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

- (void)openCouponMallVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

- (void)openCouponDetailVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

@end
