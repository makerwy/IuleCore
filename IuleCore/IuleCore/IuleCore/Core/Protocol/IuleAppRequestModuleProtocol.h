//
//  IuleAppRequestModuleProtocol.h
//  IuleCore
//
//  Created by wy on 2020/6/29.
//  Copyright © 2020 iule. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol IuleAppRequestModuleProtocol <NSObject>

@optional

- (void)requestVideoOrder:(NSDictionary *)params completeHandler:(void(^)(BOOL isSuccess, NSString *order))completeHandler;

@end
