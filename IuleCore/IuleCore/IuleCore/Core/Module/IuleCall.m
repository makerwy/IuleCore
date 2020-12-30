//
//  IuleCall.m
//  BoringSSL-GRPC
//
//  Created by mac on 2019/12/10.
//

#import "IuleCall.h"

@interface IuleObserver : NSObject
@property (nonatomic, weak) NSObject *target;
@property (nonatomic, copy) IuleRequestSuccessHandler successHandler;
@property (nonatomic, copy) IuleRequestFailHandler failHandler;

- (void)onSuccess:(id)response;

- (void)onFail:(id)error;

@end

@implementation IuleObserver

- (void)onSuccess:(id)response {
    if(_target && self.successHandler){
        self.successHandler(response);
    }
}

- (void)onFail:(IuleError *)error {
    if(_target && self.failHandler){
        self.failHandler(error);
    }
}

@end

@interface IuleCall ()
@property (nonatomic, strong) NSMutableArray *observers;

@end

@implementation IuleCall

- (void)observer:(NSObject *)target successHandler:(IuleRequestSuccessHandler)successHandler failHandler:(IuleRequestFailHandler)failHandler {
    IuleObserver * observer = [IuleObserver new];
    observer.target = target;
    observer.successHandler = successHandler;
    observer.failHandler = failHandler;
    [self.observers addObject:observer];
}

- (void)onSuccess:(id)response {
    NSLog(@"response == %@",response);
    for (IuleObserver* ob in self.observers) {
        [ob onSuccess:response];
    }
}

- (void)onFail:(IuleError *)error {
    NSLog(@"code == %zd error == %@ api == %@",error.code,error.errorMessage,error.api);
    for (IuleObserver* ob in self.observers) {
        [ob onFail:error];
    }
}

- (NSMutableArray *)observers {
    if (!_observers) {
        _observers = @[].mutableCopy;
    }
    return _observers;
}

@end
