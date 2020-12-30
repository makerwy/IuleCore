//
//  UIViewController+IuleNavigationBar.m
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIViewController+IuleNavigationBar.h"
#import <objc/runtime.h>

@implementation UIViewController (IuleNavigationBar)

- (IuleNavigationBar *)iule_navigationBar {
    IuleNavigationBar *iule_navigationBar = objc_getAssociatedObject(self, _cmd);
    if (!iule_navigationBar) {
        iule_navigationBar = [[IuleNavigationBar alloc] init];
        objc_setAssociatedObject(self, @selector(iule_navigationBar), iule_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.view addSubview:iule_navigationBar];
    }
    return iule_navigationBar;
}

- (void)setIule_navigationBar:(IuleNavigationBar *)iule_navigationBar {
    objc_setAssociatedObject(self, @selector(iule_navigationBar), iule_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
