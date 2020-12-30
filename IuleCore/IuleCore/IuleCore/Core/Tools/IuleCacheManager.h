//
//  IuleCacheManager.h
//  BoringSSL-GRPC
//
//  Created by mac on 2019/12/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IuleCacheManager : NSObject

/// 获取文件缓存路径
/// @param fileName fileName description
+ (NSString *)getCacheFilePath:(NSString *)fileName;

+ (id)getCustomModels:(NSString *)key;
+ (void)savaCustomModels:(id)data key:(NSString *)key;
+ (void)deleteCustomModels:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
