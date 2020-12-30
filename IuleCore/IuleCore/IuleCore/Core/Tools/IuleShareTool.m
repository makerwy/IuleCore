//
//  IuleShareTool.m
//  AFNetworking
//
//  Created by wangyang on 2020/2/7.
//

#import "IuleShareTool.h"

@implementation IuleShareTool

//生成二维码
+ (CIImage *)creatQRcodeWithUrlstring:(NSString *)urlString {
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data  = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}

// 将二维码转成高清的格式
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withWidth:(CGFloat)width
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(width/CGRectGetWidth(extent), width/CGRectGetHeight(extent));

    // 1.创建bitmap;
    size_t mapWidth = CGRectGetWidth(extent) * scale;
    size_t mapHeight = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, mapWidth, mapHeight, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

// 在image上添加image
+ (UIImage *)drawImage:(UIImage *)newImage inImage:(UIImage *)sourceImage rect:(CGRect)rect {
    CGSize imageSize = [sourceImage size]; //画的背景 大小
//    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
//    [sourceImage drawAtPoint:CGPointMake(0, 0)];
//    //获得 图形上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //画 自己想要画的内容(添加的图片)
//    CGContextDrawPath(context, kCGPathStroke);
//    CGContextClip(context);
//    [newImage drawInRect:rect];
//    //返回绘制的新图形
//    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
//    UIGraphicsBeginImageContext(CGSizeMake(sourceImage.size.width, sourceImage.size.height));
//    [sourceImage drawInRect:CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height)];
//    [newImage drawInRect:rect];
//    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    
    UIGraphicsBeginImageContext(CGSizeMake(imageSize.width, imageSize.height));
    [sourceImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height) blendMode:kCGBlendModeNormal alpha:1.0];
    if (newImage) {
            [newImage drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}




@end
