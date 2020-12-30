//
//  IuleBaseAdManager.h
//  IuleTouTiaoAD
//
//  Created by mac on 2019/12/21.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IulePlatformAdDelegate.h"
#import "IuleAdInfoModel.h"
#import "IuleAdConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface IuleBaseAdManager : NSObject
@property (nonatomic, weak) id <IulePlatformAdDelegate> adDelegate;
@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, copy) NSString *appId;//平台id
@property (nonatomic, copy) NSString *codeId;//代码位
@property (nonatomic, assign) CGSize adSize;//广告尺寸
@property (nonatomic, assign) NSInteger adCount;//广告数量

//广告上报使用数据
@property (nonatomic, copy) NSString *adSceneType;//广告场景
@property (nonatomic, copy) NSString *adid;//广告id

- (instancetype)initAdManagerWithDelegate:(id <IulePlatformAdDelegate>)delegate viewController:(UIViewController *)viewController;

- (void)setAdMangerInfo:(IuleAdInfoModel *)adInfo;

@end

NS_ASSUME_NONNULL_END
