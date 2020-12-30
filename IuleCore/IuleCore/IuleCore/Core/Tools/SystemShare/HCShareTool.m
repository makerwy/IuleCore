//
//  HCShareTool.m
//  HiCheng
//
//  Created by wangyang on 2018/3/14.
//  Copyright © 2018年 FXQL. All rights reserved.
//

#import "HCShareTool.h"
#import "ShareItem.h"
#import "IuleCommonMethods.h"

@implementation HCShareTool

+ (void)systemShareTit:(NSString *)titStr pic:(id)pic des:(NSString *)desStr url:(NSString *)shareUrl result:(shareBlock)result {
    if (titStr.length < 1) {
        titStr = @"";
    }
    if (desStr.length < 1) {
        desStr = @"";
    }
    if (shareUrl.length < 1) {
        NSLog(@"当前网络不好，请稍后重试");
        return;
    }
    shareUrl = [shareUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *activityItems = [NSArray array];
    if ([pic isKindOfClass:[NSString class]] && ((NSString *)pic).length > 0) {
        activityItems = @[titStr, [NSData dataWithContentsOfURL:[NSURL URLWithString:pic]], [NSURL URLWithString:shareUrl]];
        [HCShareTool shareData:activityItems result:result];
    } else if([pic isKindOfClass:[UIImage class]]) {
        activityItems = @[titStr, pic, [NSURL URLWithString:shareUrl]];
        [HCShareTool shareData:activityItems result:result];
    } else {
        activityItems = @[titStr, [UIImage imageNamed:@"iule_ic_logo"], [NSURL URLWithString:shareUrl]];
        [HCShareTool shareData:activityItems result:result];
    }
}

+ (void)systemSharePic:(id)pic result:(shareBlock)result {
    if (pic == nil) {
        NSLog(@"当前网络不好，请稍后重试");
        return;
    }
    NSArray *activityItems = @[];
    if ([pic isKindOfClass:[NSString class]]) {
        activityItems = @[[NSData dataWithContentsOfURL:[NSURL URLWithString:pic]]];
    }else if ([pic isKindOfClass:[UIImage class]]) {
        activityItems = @[UIImagePNGRepresentation(pic)];
    }
    [HCShareTool shareData:activityItems result:result];
}

+ (void)systemShareManyPic:(NSArray *)pics result:(shareBlock)result {
    UIViewController *vc = [IuleCommonMethods topViewController];
    NSMutableArray *items = [NSMutableArray array];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    for (int i = 0; i < pics.count; i++) {
        //地址转码，取出地址
        NSString *URL = [pics[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //把图片转成NSData类型
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
        //写入图片中
        UIImage *imagerang = [UIImage imageWithData:data];
        //图片缓存的地址，自己进行替换
        NSString *dateStr = [IuleCommonMethods timestampWithDate:[NSDate date]];
        NSString *imagePath = [docPath stringByAppendingString:[NSString stringWithFormat:@"/%@%d.jpeg",dateStr,i]];
        //把图片写进缓存，一定要先写入本地，不然会分享出错
        if ([UIImagePNGRepresentation(imagerang) writeToFile:imagePath atomically:YES]) {
            //把缓存图片的地址转成NSUrl格式
            NSURL *shareobj = [NSURL fileURLWithPath:imagePath];
            //这个部分是自定义ActivitySource
            ShareItem *item = [[ShareItem alloc] initWithImage:imagerang URL:shareobj];
            //分享的数组
            [items addObject:item];
        }
    }
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];//,UIActivityTypeCopyToPasteboard,UIActivityTypeSaveToCameraRoll,UIActivityTypeOpenInIBooks
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [vc presentViewController:activityViewController animated:YES completion:nil];
    } else { // iPad
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
        [popover presentPopoverFromRect:CGRectMake(vc.view.frame.size.width/2, vc.view.frame.size.height/4, 0, 0)
                                 inView:vc.view permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
    }
    activityViewController.completionWithItemsHandler = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        // QQ com.tencent.mqq.ShareExtension
        // 空间 com.tencent.mqq.ShareExtension
        // 微信 com.tencent.xin.sharetimeline
        if (completed && activityType) {
            if (result) {
                result(YES);
            }
        } else {
            if (result) {
                result(NO);
            }
        }
    };
}

+ (void)shareData:(NSArray *)activityItems result:(shareBlock)result {
    //系统分享
    UIViewController *vc = [IuleCommonMethods topViewController];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypePostToTwitter,UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop];//,UIActivityTypeCopyToPasteboard,UIActivityTypeSaveToCameraRoll,UIActivityTypeOpenInIBooks
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [vc presentViewController:activityViewController animated:YES completion:nil];
    } else { // iPad
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
        [popover presentPopoverFromRect:CGRectMake(vc.view.frame.size.width/2, vc.view.frame.size.height/4, 0, 0)
                                 inView:vc.view permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
    }
    activityViewController.completionWithItemsHandler = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        // QQ com.tencent.mqq.ShareExtension
        // 空间 com.tencent.mqq.ShareExtension
        // 微信 com.tencent.xin.sharetimeline
        if (completed && activityType) {
            NSLog(@"分享成功");
            if (result) {
                result(YES);
            }
        } else {
            NSLog(@"分享失败");
            if (result) {
                result(NO);
            }
        }
    };
}

@end
