//
//  IuleError.h
//  BoringSSL-GRPC
//
//  Created by mac on 2019/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IuleError : NSObject
@property (nonatomic, copy) NSString *api;
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSDictionary *errorInfo;

+ (instancetype)errorWithCode:(NSInteger)code errorInfo:(NSDictionary *)errorInfo api:(NSString *)api;

+ (instancetype)errorWithCode:(NSInteger)code errorInfo:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
