//
//  IuleBaseModel.h
//  IuleCore
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IuleBaseModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)iule_keyValues;

@end

NS_ASSUME_NONNULL_END
