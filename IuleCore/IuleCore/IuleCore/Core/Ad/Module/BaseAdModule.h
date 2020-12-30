//
//  BaseAdModule.h
//  IuleCore
//
//  Created by wy on 2020/6/12.
//  Copyright © 2020 iule. All rights reserved.
//

#import <IuleCore/IuleCore.h>
#import "IuleAdProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseAdModule : IuleBaseModule<IuleAdProtocol>
@property (nonatomic, strong) NSMutableDictionary *adManagerDic;
@property (nonatomic, copy) NSString *orderNum;

@end

NS_ASSUME_NONNULL_END
