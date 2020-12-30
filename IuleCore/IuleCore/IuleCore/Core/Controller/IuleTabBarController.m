//
//  IuleTabBarController.m
//  IuleCore
//
//  Created by mac on 2020/5/19.
//

#import "IuleTabBarController.h"
#import "IuleNavigationController.h"
#import "UIColor+LYHex.h"
#import "IuleCommonMethods.h"
#import "IuleLoginModuleProtocol.h"
#import "IuleModuleCenter.h"

@interface IuleTabBarController ()<UITabBarControllerDelegate>

@end

@implementation IuleTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  主页成为根数图控制器
 */
- (void)tabBarControllerWithControllers:(NSArray *)controllers
                         darkImageNames:(NSArray *)darkImageNames
                        lightImageNames:(NSArray *)lightImageNames
                            tabBarNames:(NSArray *)names {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0 ; i < controllers.count; i ++) {
        //图标
        UIImage * image1 = [UIImage imageNamed:lightImageNames [i]];
        image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * image2 = [UIImage imageNamed:darkImageNames [i]];;
        image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIViewController *vc = [NSClassFromString(controllers [i]) new];
        IuleNavigationController *nav = [[IuleNavigationController alloc] initWithRootViewController:vc];
        [nav preferredStatusBarStyle];
        nav.tabBarItem.title = names [i];
        nav.tabBarItem.image = image2;
        nav.tabBarItem.selectedImage = image1;
        nav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 0);
        [array addObject:nav];
        [nav.tabBarItem setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:[UIColor ly_colorWithHexString:@"#F75305"],
          NSForegroundColorAttributeName,
          nil] forState:UIControlStateSelected];
    }
    
    self.viewControllers = array;
    self.delegate = self;
    self.tabBar.barTintColor = [UIColor whiteColor];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSString *token = [IuleCommonMethods ly_valuerForKey:@"token"];
    if (token.length == 0) {
        if (!(tabBarController.selectedIndex == 0 || tabBarController.selectedIndex == 1)) {
            tabBarController.selectedIndex = 0;
        }
        IuleNavigationController *nav = (IuleNavigationController *)viewController;
        UIViewController *fistrVC = nav.viewControllers.firstObject;
        if ([fistrVC isKindOfClass:NSClassFromString(@"IuleDevOrderListVC")] || [fistrVC isKindOfClass:NSClassFromString(@"IuleDevMineVC")]) {
            id<IuleLoginModuleProtocol> module = [[IuleModuleCenter defaultCenter] module:@"IuleDevLogin" protocol:@"IuleLoginModuleProtocol"];
            if (module) {
                [module openLoginVC:@{} completeHandler:nil];
            }
            return NO;
        }
        if ([fistrVC isKindOfClass:NSClassFromString(@"IuleOrderListViewController")]) {
            id<IuleLoginModuleProtocol> module = [[IuleModuleCenter defaultCenter] module:@"IuleLogin" protocol:@"IuleLoginModuleProtocol"];
            if (module) {
                [module openLoginVC:@{} completeHandler:nil];
            }
            return NO;
        }
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}


@end
