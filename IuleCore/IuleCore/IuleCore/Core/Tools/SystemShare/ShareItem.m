//
//  ShareItem.m
//  HiCheng
//
//  Created by wangyang on 2018/6/12.
//  Copyright © 2018年 FXQL. All rights reserved.
//

#import "ShareItem.h"

@interface ShareItem ()<UIActivityItemSource>
//传入的图片
@property (nonatomic, strong) UIImage *img;
//保存图片的本地路径
@property (nonatomic, strong) NSURL *filePath;

@end

@implementation ShareItem

- (instancetype)initWithImage:(id)img URL:(NSURL *)URL {
    self = [super init];
    if (self) {
        _img = img;
        _filePath = URL;
    }
    return self;
}


#pragma mark - UIActivityItemSource代理
//@required
- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return _img;
}
//@required
- (id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType
{
    return _filePath;
}

//@optional
- (NSString*)activityViewController:(UIActivityViewController *)activityViewController subjectForActivityType:(NSString *)activityType
{
    return nil;
}

//@optional
- (UIImage *)activityViewController:(UIActivityViewController *)activityViewController thumbnailImageForActivityType:(NSString *)activityType suggestedSize:(CGSize)size{
    return nil;
}

//@optional
- (NSString *)activityViewController:(UIActivityViewController *)activityViewController dataTypeIdentifierForActivityType:(NSString *)activityType
{
    return nil;
}

@end
