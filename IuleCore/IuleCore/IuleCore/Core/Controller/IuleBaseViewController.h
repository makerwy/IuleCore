//
//  IuleBaseViewController.h
//  IuleCore
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 iule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+IuleNavigationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface IuleBaseViewController : UIViewController

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;//关闭全屏侧滑

@property (nonatomic, assign) NSInteger offset;//当前页

- (void)backButton:(NSString *)backButton;

/**
 点击返回
 */
- (void)goback;

@end

NS_ASSUME_NONNULL_END
