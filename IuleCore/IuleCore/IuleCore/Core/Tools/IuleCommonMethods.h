//
//  IuleCommonMethods.h
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IuleCommonMethods : NSObject

/**
 获取当前VC
 
 @return return value description
 */
+ (UIViewController *)currentVC;

+ (UIViewController *)topViewController;

/**
 倒计时
 
 @param allSecond 总秒数
 @param perSecond 每秒回调
 @param end 结束回调
 */
+ (void)countDownWithAllSecond:(NSInteger)allSecond
                     perSecond:(void(^)(NSInteger second))perSecond
                           end:(void(^)(void))end;

#pragma mark -
#pragma mark - 关于存储

/**
 NSUserDefaults
 
 @param key key description
 @return return value description
 */
+ (id)ly_valuerForKey:(NSString *)key;

/**
 NSUserDefaults
 
 @param value value description
 @param key key description
 */
+ (void)ly_setValue:(id)value forKey:(NSString *)key;

/**
 NSUserDefaults

 @param key key description
 */
+ (void)ly_removeValueForKey:(NSString *)key;

#pragma mark -
#pragma mark - 关于时间

/**
 date 转 固定格式时间
 
 @param date date
 @param formatter 格式
 @return 字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date
                   formatter:(NSString *)formatter;

/**
时间戳 计算与系统时间差值

@param timeString 时间戳字符串
@return 字符串
*/
+ (NSString *)getNowTimeWithString:(NSString *)timeString;

/**
 时间戳 计算与系统时间差值 00:00:00:00

 @param timeString 时间戳字符串
 @return 字符串
 */
+ (NSString *)getCountDownTimeWithString:(NSString *)timeString;

/**
 时间戳 计算与系统时间差值 00:00:00:00

 yyyy:MM:dd HH:mm:ss
 @param timeString 时间戳字符串
 @return 字符串
 */
+ (NSString *)getCountDownTimeWithString:(NSString *)timeString formatter:(NSString *)formatter;

/**
 时间戳 转 固定格式时间
 
 @param timeString 时间戳字符串
 @param formatter 格式
 @return 字符串
 */
+ (NSString *)stringWith1970TimeString:(NSString *)timeString
                             formatter:(NSString *)formatter;

/**
 时间字符串格式转换
 
 @param timeString 需要转换的时间字符串
 @param fromFormatter 当前格式
 @param toFormatter 转换后的格式
 @return 新的时间字符串
 */
+ (NSString *)stringWithTimeString:(NSString *)timeString
                     fromFormatter:(NSString *)fromFormatter
                       toFormatter:(NSString *)toFormatter;

/**
 固定格式时间 转 时间戳
 
 @param timeString 时间
 @param formatter 格式
 @return 时间戳
 */
+ (NSString *)timestampWithTimeString:(NSString *)timeString
                            formatter:(NSString *)formatter;

/**
 date 转 时间戳字符串
 
 @param date 时间
 @return 时间戳字符串
 */
+ (NSString *)timestampWithDate:(NSDate *)date;

/**
 固定格式时间 转 date
 
 @param timeString 时间字符串
 @param formatter 格式
 @return date
 */
+ (NSDate *)dateWithTimeString:(NSString *)timeString
                     formatter:(NSString *)formatter;

/**
 时间戳 转 date
 
 @param timeString 时间戳
 @return date
 */
+ (NSDate *)dateWith1970TimeString:(NSString *)timeString;

#pragma mark -
#pragma mark - 关于系统弹框

/**
 弹框 UIAlertViewController 取消 + 确定 alert
 
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
                                    sureBlock:(void(^)(void))sureBlock;

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
                                             sureBlock:(void(^)(NSString *text))sureBlock;

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
                                    sureBlock:(void(^)(UIAlertAction *action))sureBlock;
@end

NS_ASSUME_NONNULL_END
