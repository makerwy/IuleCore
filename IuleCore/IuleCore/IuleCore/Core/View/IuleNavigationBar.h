//
//  IuleNavigationBar.h
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IuleNavigationBar : UIView

@property(copy, nonatomic) NSString *title;
@property(copy, nonatomic) NSAttributedString *attributedTitle;
@property(copy, nonatomic) NSString *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property(copy, nonatomic) NSString *rightButtonTitle;
@property(copy, nonatomic) NSString *rightButtonTitleColor;
@property(copy, nonatomic) NSString *rightButtonImage;
@property (nonatomic, strong) UIColor *titleColorHex;
@property(strong, nonatomic) UIView *titleView;
@property(strong, nonatomic) UIButton *leftButton;
@property(strong, nonatomic) UIButton *rightButton;

@property(assign, nonatomic) BOOL hiddenLeftButton;

- (void)removeNavigationBarBottomLine:(BOOL)hidden;
- (void)addCustemView:(UIView *)custemView;
- (void)addBackgroundCustemView:(UIView *)custemView;

@end

NS_ASSUME_NONNULL_END
