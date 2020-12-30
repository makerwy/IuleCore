//
//  IuleCacheManager.m
//  BoringSSL-GRPC
//
//  Created by mac on 2019/12/14.
//

#import "IuleCacheManager.h"

@implementation IuleCacheManager

/// 缓存根路径
+ (NSString *)cacheFilePath {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *createPath = [pathDocuments stringByAppendingPathComponent:@"IuleCahceFiles"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        NSError *error = nil;
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return createPath;
}

/// 获取文件缓存路径
/// @param fileName fileName description
+ (NSString *)getCacheFilePath:(NSString *)fileName {
//    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *createPath = [[self cacheFilePath] stringByAppendingPathComponent:fileName];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
//        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
    return createPath;
}

+ (id)getCustomModels:(NSString *)key {
    NSString *keyPath = [[self getCacheFilePath:key] stringByAppendingString:@".plist"];
    id data = [NSKeyedUnarchiver unarchiveObjectWithFile:keyPath];
    return data;
}

+ (void)savaCustomModels:(id)data key:(NSString *)key {
    NSString *keyPath = [[self getCacheFilePath:key] stringByAppendingString:@".plist"];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![[NSFileManager defaultManager] fileExistsAtPath:keyPath]) {
        NSData *data = [fileManager contentsAtPath:keyPath];
        [fileManager createFileAtPath:keyPath contents:data attributes:nil];
    }
    [NSKeyedArchiver archiveRootObject:data toFile:keyPath];
}

+ (void)deleteCustomModels:(NSString *)key {
    NSString *keyPath = [[self getCacheFilePath:key] stringByAppendingString:@".plist"];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSError *error;
    if ([fileManager removeItemAtPath:keyPath error:&error]) {
        NSLog(@"删除成功");
    }else {
        NSLog(@"删除失败");
    }
}

@end
