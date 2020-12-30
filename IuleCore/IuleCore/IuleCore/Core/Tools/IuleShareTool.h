//
//  IuleShareTool.h
//  AFNetworking
//
//  Created by wangyang on 2020/2/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IuleShareTool : NSObject

//生成二维码
+ (CIImage *)creatQRcodeWithUrlstring:(NSString *)urlString;

// 将二维码转成高清的格式
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withWidth:(CGFloat)width;

// 在image上添加image
+ (UIImage *)drawImage:(UIImage *)newImage inImage:(UIImage *)sourceImage rect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
