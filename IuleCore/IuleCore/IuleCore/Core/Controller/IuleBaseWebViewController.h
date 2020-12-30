//
//  IuleBaseWebViewController.h
//  IuleCore
//
//  Created by mac on 2019/12/2.
//  Copyright © 2019 iule. All rights reserved.
//

#import "IuleBaseViewController.h"
#import "IuleBaseWebProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface IuleBaseWebViewController : IuleBaseViewController

@property (nonatomic, weak) id <IuleBaseWebProtocol> delegate;

- (void)loadUrl:(NSString *)url frame:(CGRect)frame;

- (void)loadUrl:(NSString *)url frame:(CGRect)frame referer:(NSString *)referer;

- (void)loadHTMLString:(NSString *)HTMLString frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
