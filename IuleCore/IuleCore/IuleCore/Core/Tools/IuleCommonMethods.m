//
//  IuleCommonMethods.m
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "IuleCommonMethods.h"

@implementation IuleCommonMethods

#pragma mark -
#pragma mark - 系统层级 获取当前VC

/**
 获取当前VC
 
 @return return value description
 */
+ (UIViewController *)currentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    } else{
        if (window.subviews.count > 0) {
            UIView *frontView = [[window subviews] objectAtIndex:0];
            nextResponder = [frontView nextResponder];
        }else {
            nextResponder = appRootVC;
        }
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = tabbar.selectedViewController ; // 上下两种写法都行
        result = nav.childViewControllers.lastObject;
        if (!result) {
            result = nav;
        }
    } else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    } else {
        result = nextResponder;
    }
    return result;
}

//+ (UIViewController *)topViewController {
//    //获取根控制器
//    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
//
//    UIViewController *parent = rootVC;
//    //遍历 如果是presentViewController
//    while ((parent = rootVC.presentedViewController) != nil ) {
//        rootVC = parent;
//    }
//
//    while ([rootVC isKindOfClass:[UINavigationController class]]) {
//        rootVC = [(UINavigationController *)rootVC topViewController];
//    }
//    return rootVC;
//}

+ (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

/**
 倒计时
 
 @param allSecond 总秒数
 @param perSecond 每秒回调
 @param end 结束回调
 */
+ (void)countDownWithAllSecond:(NSInteger)allSecond
                     perSecond:(void(^)(NSInteger second))perSecond
                           end:(void(^)(void))end {
    if (allSecond == 0) {
        return;
    }
    __block NSInteger timeout = allSecond;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (end) {
                    end();
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (perSecond) {
                    perSecond(timeout);
                }
                timeout --;
            });
        }
    });
    dispatch_resume(_timer);
}

#pragma mark -
#pragma mark - 关于存储

/**
 NSUserDefaults
 
 @param key key description
 @return return value description
 */
+ (id)ly_valuerForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

/**
 NSUserDefaults
 
 @param value value description
 @param key key description
 */
+ (void)ly_setValue:(id)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 NSUserDefaults
 
 @param key key description
 */
+ (void)ly_removeValueForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

#pragma mark -
#pragma mark - 关于时间

/**
 date 转 固定格式时间
 
 @param date date
 @param formatter 格式
 @return 字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date
                   formatter:(NSString *)formatter {
    if (!formatter) {
        return nil;
    }
    if (!date) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/**
 时间戳 计算与系统时间差值
 
 @param timeString 时间戳字符串
 @return 字符串
 */
+ (NSString *)getNowTimeWithString:(NSString *)timeString {
    NSDate *nowDate = [NSDate date];//获取当前时间0秒后的时间
    
    NSTimeInterval startTime = [timeString doubleValue];
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:startTime];
    //对比得到差值
    NSTimeInterval timeInterval = [detaildate timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval / (3600 * 24));
    int hours = (int)((timeInterval - days * 24 * 3600) / 3600);
    int minutes = (int)(timeInterval - days * 24 * 3600 - hours * 3600) / 60;
    int seconds = timeInterval - days * 24 * 3600 - hours * 3600 - minutes * 60;
    
    //以下按自己需要使用
    NSString *dayStr = [NSString stringWithFormat:@"%02d",days];
    NSString *hoursStr = [NSString stringWithFormat:@"%02d",hours];
    NSString *minutesStr = [NSString stringWithFormat:@"%02d",minutes];
    NSString *secondsStr = [NSString stringWithFormat:@"%02d", seconds];
    
    if (hours <= 0 && minutes <= 0 && seconds <= 0) {
        return @"已超时";
    }
    
    if (days) {
        return [NSString stringWithFormat:@"%@天%@时%@分%@秒", dayStr,hoursStr, minutesStr,secondsStr];
    } else if(hours){
        return [NSString stringWithFormat:@"%@时%@分%@秒", hoursStr,minutesStr,secondsStr];
    }else
        return [NSString stringWithFormat:@"%@分%@秒", minutesStr,secondsStr];
}

/**
 时间戳 计算与系统时间差值 00:00:00:00

 @param timeString 时间戳字符串
 @return 字符串
 */
+ (NSString *)getCountDownTimeWithString:(NSString *)timeString {
    NSDate *nowDate = [NSDate date];//获取当前时间0秒后的时间

    NSTimeInterval startTime = [timeString doubleValue];
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:startTime];
    //对比得到差值
    NSTimeInterval timeInterval = [detaildate timeIntervalSinceDate:nowDate];

    int days = (int)(timeInterval / (3600 * 24));
    int hours = (int)((timeInterval - days * 24 * 3600) / 3600);
    int minutes = (int)(timeInterval - days * 24 * 3600 - hours * 3600) / 60;
    int seconds = timeInterval - days * 24 * 3600 - hours * 3600 - minutes * 60;

    //以下按自己需要使用
    NSString *dayStr = [NSString stringWithFormat:@"%02d",days];
    NSString *hoursStr = [NSString stringWithFormat:@"%02d",hours];
    NSString *minutesStr = [NSString stringWithFormat:@"%02d",minutes];
    NSString *secondsStr = [NSString stringWithFormat:@"%02d", seconds];

    if (hours <= 0 && minutes <= 0 && seconds <= 0) {
        return @"00:00:00";
    }

    if (days) {
        return [NSString stringWithFormat:@"%@:%@:%@:%@", dayStr,hoursStr, minutesStr,secondsStr];
    } else if(hours){
        return [NSString stringWithFormat:@"%@:%@:%@", hoursStr,minutesStr,secondsStr];
    }else
        return [NSString stringWithFormat:@"%@:%@:%@", hoursStr,minutesStr,secondsStr];
}


/**
 时间戳 计算与系统时间差值 00:00:00:00

 yyyy:MM:dd HH:mm:ss
 @param timeString 时间戳字符串
 @return 字符串
 */
+ (NSString *)getCountDownTimeWithString:(NSString *)timeString formatter:(NSString *)formatter {
    NSDate *nowDate = [NSDate date];//获取当前时间0秒后的时间

    NSTimeInterval startTime = [timeString doubleValue];
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:startTime];
    //对比得到差值
    NSTimeInterval timeInterval = [detaildate timeIntervalSinceDate:nowDate];

    int days = (int)(timeInterval / (3600 * 24));
    int hours = (int)((timeInterval - days * 24 * 3600) / 3600);
    int minutes = (int)(timeInterval - days * 24 * 3600 - hours * 3600) / 60;
    int seconds = timeInterval - days * 24 * 3600 - hours * 3600 - minutes * 60;

    //以下按自己需要使用
    NSString *dayStr = [NSString stringWithFormat:@"%02d",days];
    NSString *hoursStr = [NSString stringWithFormat:@"%02d",hours];
    NSString *minutesStr = [NSString stringWithFormat:@"%02d",minutes];
    NSString *secondsStr = [NSString stringWithFormat:@"%02d", seconds];

    if (formatter.length == 0) {
        formatter = @"HH:mm:ss";
    }
    
    NSString *resultTime = formatter;
    if ([formatter containsString:@"dd"]) {
        resultTime = [resultTime stringByReplacingOccurrencesOfString:@"dd" withString:dayStr];
    }
    if ([formatter containsString:@"HH"]) {
        resultTime = [resultTime stringByReplacingOccurrencesOfString:@"HH" withString:hoursStr];
    }
    if ([formatter containsString:@"mm"]) {
        resultTime = [resultTime stringByReplacingOccurrencesOfString:@"mm" withString:minutesStr];
    }
    if ([formatter containsString:@"ss"]) {
        resultTime = [resultTime stringByReplacingOccurrencesOfString:@"ss" withString:secondsStr];
    }
    
    if (hours <= 0 && minutes <= 0 && seconds <= 0) {
        return @"已超时";
    }
    return resultTime;
}
   
/**
 时间戳 转 固定格式时间
 
 @param timeString 时间戳字符串
 @param formatter 格式
 @return 字符串
 */
+ (NSString *)stringWith1970TimeString:(NSString *)timeString
                             formatter:(NSString *)formatter {
    NSTimeInterval timeInterval;
    if (timeString.length == 13) {
        // JAVA
        timeInterval = [timeString doubleValue] / 1000;
    } else if (timeString.length == 10) {
        // PHP
        timeInterval = [timeString doubleValue];
    } else {
        return nil;
    }
    if (!formatter) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

/**
 时间字符串格式转换
 
 @param timeString 需要转换的时间字符串
 @param fromFormatter 当前格式
 @param toFormatter 转换后的格式
 @return 新的时间字符串
 */
+ (NSString *)stringWithTimeString:(NSString *)timeString
                     fromFormatter:(NSString *)fromFormatter
                       toFormatter:(NSString *)toFormatter {
    if (!fromFormatter) {
        return nil;
    }
    if (!toFormatter) {
        return nil;
    }
    if (!timeString) {
        return nil;
    }
    NSDate *date = [IuleCommonMethods dateWithTimeString:timeString formatter:fromFormatter];
    NSString *newSting = [IuleCommonMethods stringWithDate:date formatter:toFormatter];
    return newSting;
}

/**
 固定格式时间 转 时间戳
 
 @param timeString 时间
 @param formatter 格式
 @return 时间戳
 */
+ (NSString *)timestampWithTimeString:(NSString *)timeString
                            formatter:(NSString *)formatter {
    if (!formatter) {
        return nil;
    }
    if (!timeString) {
        return nil;
    }
    NSDate *date = [IuleCommonMethods dateWithTimeString:timeString formatter:formatter];
    NSString *timestamp = [NSString stringWithFormat:@"%lf",[date timeIntervalSince1970]];
    return timestamp;
}

/**
 date 转 时间戳字符串
 
 @param date 时间
 @return 时间戳字符串
 */
+ (NSString *)timestampWithDate:(NSDate *)date {
    if (!date) {
        return nil;
    }
    NSString *timestamp = [NSString stringWithFormat:@"%ld",(long)([date timeIntervalSince1970])];
    return timestamp;
}

/**
 固定格式时间 转 date
 
 @param timeString 时间字符串
 @param formatter 格式
 @return date
 */
+ (NSDate *)dateWithTimeString:(NSString *)timeString
                     formatter:(NSString *)formatter {
    if (!formatter) {
        return nil;
    }
    if (!timeString) {
        return nil;
    }
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:formatter];
    NSDate *date = [formatter2 dateFromString:timeString];
    return date;
}

/**
 时间戳 转 date
 
 @param timeString 时间戳
 @return date
 */
+ (NSDate *)dateWith1970TimeString:(NSString *)timeString {
    if (!timeString) {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970:[timeString integerValue]];
}

#pragma mark -
#pragma mark - 关于系统弹框

/**
 弹框 UIAlertViewController
 
 @param title 标题
 @param message 提示语
 @param cancelButtonTitle 取消按钮
 @param sureButtonTitle 确定按钮
 @param cancelBlock 取消回调
 @param sureBlock 确定回调
 */
+ (UIAlertController *)showAlertViewWithTitle:(NSString *)title
                                      message:(NSString *)message
                            cancelButtonTitle:(NSString *)cancelButtonTitle
                              sureButtonTitle:(NSString *)sureButtonTitle
                                  cancelBlock:(void(^)(void))cancelBlock
                                    sureBlock:(void(^)(void))sureBlock {
    UIViewController *viewController = [IuleCommonMethods topViewController];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (sureButtonTitle) {
        UIAlertAction * actionSure = [UIAlertAction actionWithTitle:sureButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sureBlock) {
                sureBlock();
            }
        }];
        [alertVC addAction:actionSure];
    }
    if (cancelButtonTitle.length) {
        UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [alertVC addAction:actionCancel];
    }
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPad"]) {
        if ([viewController isKindOfClass:[UIWindow class]]) {
            alertVC.popoverPresentationController.sourceView = (UIWindow *)viewController;
            [[(UIWindow *)viewController rootViewController] presentViewController:alertVC animated:YES completion:nil];
        }else {
            alertVC.popoverPresentationController.sourceView = [(UIViewController *)viewController view];
            [viewController presentViewController:alertVC animated:YES completion:nil];
        }
        return alertVC;
    }
    [viewController presentViewController:alertVC animated:YES completion:nil];
    return alertVC;
}

/**
 弹框 UIAlertViewController 带输入框
 
 @param title 标题
 @param message 提示语
 @param placeholder 占位图
 @param cancelButtonTitle 取消按钮
 @param sureButtonTitle 确定按钮
 @param cancelBlock 取消回调
 @param sureBlock 确定回调
 */
+ (UIAlertController *)showTextFieldAlertViewWithTitle:(NSString *)title
                                               message:(NSString *)message
                                           placeholder:(NSString *)placeholder
                                     cancelButtonTitle:(NSString *)cancelButtonTitle
                                       sureButtonTitle:(NSString *)sureButtonTitle
                                           cancelBlock:(void(^)(void))cancelBlock
                                             sureBlock:(void(^)(NSString *text))sureBlock {
    UIViewController *viewController = [IuleCommonMethods topViewController];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholder;
    }];
    if (sureButtonTitle) {
        UIAlertAction * actionSure = [UIAlertAction actionWithTitle:sureButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sureBlock) {
                sureBlock(alertVC.textFields.lastObject.text);
            }
        }];
        [alertVC addAction:actionSure];
    }
    if (cancelButtonTitle.length) {
        UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [alertVC addAction:actionCancel];
    }
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPad"]) {
        if ([viewController isKindOfClass:[UIWindow class]]) {
            alertVC.popoverPresentationController.sourceView = (UIWindow *)viewController;
            [[(UIWindow *)viewController rootViewController] presentViewController:alertVC animated:YES completion:nil];
        }else {
            alertVC.popoverPresentationController.sourceView = [(UIViewController *)viewController view];
            [viewController presentViewController:alertVC animated:YES completion:nil];
        }
        return alertVC;
    }
    [viewController presentViewController:alertVC animated:YES completion:nil];
    return alertVC;
}

/**
 弹框 UIAlertViewController sheet
 
 @param title 标题
 @param message 提示语
 @param cancelButtonTitle 取消按钮
 @param titleArray 按钮标题数组
 @param cancelBlock 取消回调
 @param sureBlock 确定回调
 */
+ (UIAlertController *)showSheetViewWithTitle:(NSString *)title
                                      message:(NSString *)message
                            cancelButtonTitle:(NSString *)cancelButtonTitle
                                   titleArray:(NSArray <NSString *>*)titleArray
                                  cancelBlock:(void(^)(void))cancelBlock
                                    sureBlock:(void (^)(UIAlertAction *))sureBlock {
    UIViewController *viewController = [IuleCommonMethods topViewController];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    [titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction * actionSure = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sureBlock) {
                sureBlock(action);
            }
        }];
        [alertVC addAction:actionSure];
    }];
    if (cancelButtonTitle) {
        UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [alertVC addAction:actionCancel];
    }
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType isEqualToString:@"iPad"]) {
        if ([viewController isKindOfClass:[UIWindow class]]) {
            alertVC.popoverPresentationController.sourceView = (UIWindow *)viewController;
            [[(UIWindow *)viewController rootViewController] presentViewController:alertVC animated:YES completion:nil];
        }else {
            alertVC.popoverPresentationController.sourceView = [(UIViewController *)viewController view];
            [viewController presentViewController:alertVC animated:YES completion:nil];
        }
        return alertVC;
    }
    
    //    alertVC.view.tintColor = [UIColor colorWithHexString:@"0f0f0f"];
    //    //改变title的大小和颜色
    //    if (title.length > 0) {
    //        NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
    //        [titleAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, title.length)];
    //        [titleAtt addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0F0F0F"] range:NSMakeRange(0, title.length)];
    //        [alertVC setValue:titleAtt forKey:@"attributedTitle"];
    //    }
    //    if (message.length > 0) {
    //        //改变message的大小和颜色
    //        NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
    //        [messageAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, message.length)];
    //        [messageAtt addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0F0F0F"] range:NSMakeRange(0, message.length)];
    //        [alertVC setValue:messageAtt forKey:@"attributedMessage"];
    //    }
    [viewController presentViewController:alertVC animated:YES completion:nil];
    return alertVC;
}

@end
