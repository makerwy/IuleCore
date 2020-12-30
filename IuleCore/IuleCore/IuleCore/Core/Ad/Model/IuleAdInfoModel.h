//
//  IuleAdInfoModel.h
//  IuleCore
//
//  Created by mac on 2019/12/20.
//  Copyright © 2019 iule. All rights reserved.
//

#import "IuleBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IuleAdInfoModel : IuleBaseModel
/** 广告appId */
@property(nonatomic, copy) NSString *appId;
/** 广告平台 */
@property(nonatomic, copy) NSString *platform;
/** 广告类型 */
@property(nonatomic, copy) NSString *adType;
/** 广告场景类型 */
@property(nonatomic, copy) NSString *adScene;
/** 优先级 */
@property(nonatomic, assign) int32_t priority;
/** 广告代码位Id */
@property (nonatomic, copy) NSString *codeId;
@property (nonatomic, copy) NSString *appName;


@property (nonatomic, assign) CGFloat acceptWidth;
@property (nonatomic, assign) CGFloat acceptHeight;
@property (nonatomic, assign) CGFloat expressWidth;
@property (nonatomic, assign) CGFloat expressHeight;
@property (nonatomic, assign) BOOL supportDeepLink;
@property (nonatomic, assign) NSInteger timeOut;

@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) BOOL orientation;

@property (nonatomic, assign) CGFloat realWidth;
@property (nonatomic, assign) CGFloat realHeight;

@property (nonatomic, assign) BOOL hasReachMaxShow;//已经达到广告展示当日最大次数


@end

NS_ASSUME_NONNULL_END
