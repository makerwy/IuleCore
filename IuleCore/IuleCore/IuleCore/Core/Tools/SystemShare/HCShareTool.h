//
//  HCShareTool.h
//  HiCheng
//
//  Created by wangyang on 2018/3/14.
//  Copyright © 2018年 FXQL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^shareBlock)(BOOL isSuccess);
typedef void(^ShareStateBlock)(BOOL isSuccess);

@interface HCShareTool : NSObject

/** 系统分享 */
+ (void)systemShareTit:(NSString *)titStr
                   pic:(id)pic
                   des:(NSString *)desStr
                   url:(NSString *)shareUrl
                result:(shareBlock)result;

+ (void)systemSharePic:(id)pic result:(shareBlock)result;

+ (void)systemShareManyPic:(NSArray *)pics result:(shareBlock)result;

+ (void)shareData:(NSArray *)activityItems result:(shareBlock)result;

@end
