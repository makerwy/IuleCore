//
//  IuleFriendModuleProtocol.h
//  IuleCore
//
//  Created by wangyang on 2020/8/26.
//  Copyright © 2020 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IuleFriendModuleProtocol <NSObject>

@optional

- (void)openFriendListVC:(NSDictionary *)params completeHandler:(void (^)(void))completeHandler;

@end
