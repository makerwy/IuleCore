//
//  IuleCall.h
//  BoringSSL-GRPC
//
//  Created by mac on 2019/12/10.
//

#import <Foundation/Foundation.h>
#import "IuleError.h"

typedef void(^IuleRequestSuccessHandler)(id _Nullable result);
typedef void(^IuleRequestFailHandler)(IuleError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface IuleCall : NSObject

- (void)observer:(NSObject *)target
  successHandler:(IuleRequestSuccessHandler)successHandler
     failHandler:(IuleRequestFailHandler)failHandler;

- (void)onSuccess:(id)response;

- (void)onFail:(IuleError *)error;

@end

NS_ASSUME_NONNULL_END
