//
//  IuleNavigationBar.m
//  LYProject
//
//  Created by mac on 2019/9/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "IuleNavigationBar.h"
#import "UIButton+LYPosition.h"
#import "UIView+LYCategory.h"
#import "UIColor+LYHex.h"
#import "NSString+LYSize.h"
#import "UILabel+LYCreate.h"
#import "IuleConst.h"

@interface IuleNavigationBar ()
@property(strong, nonatomic) UIView *lineView;
@property(strong, nonatomic) UIView *contentView;
@property(strong, nonatomic) UILabel *titleLabel;

@end

@implementation IuleNavigationBar

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kIuleScreenW, kIuleNavH);
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.leftButton];
    }
    return self;
}

#pragma mark
#pragma mark -- pravate methods

- (void)removeNavigationBarBottomLine:(BOOL)hidden {
    self.lineView.hidden = hidden;
}

#pragma mark
#pragma mark -- setter

- (void)setHiddenLeftButton:(BOOL)hiddenLeftButton {
    _hiddenLeftButton = hiddenLeftButton;
    self.leftButton.hidden = hiddenLeftButton;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}

- (void)setAttributedTitle:(NSAttributedString *)attributedTitle {
    _attributedTitle = attributedTitle;
    self.titleLabel.attributedText = attributedTitle;
}

- (void)setTitleColor:(NSString *)titleColor {
    _titleColor = titleColor;
    self.titleLabel.textColor = [UIColor ly_colorWithHexString:titleColor];
}

- (void)setTitleColorHex:(UIColor *)titleColorHex {
    _titleColorHex = titleColorHex;
    self.titleLabel.textColor = titleColorHex;
}

- (void)setRightButtonTitle:(NSString *)rightButtonTitle {
    _rightButtonTitle = rightButtonTitle;
    
    CGFloat width = [rightButtonTitle ly_widthWithFont:[UIFont systemFontOfSize:14]];
    if (self.rightButton) {
        [self.rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
    }else {
        self.rightButton = [UIButton ly_buttonWithTitle:rightButtonTitle titleColor:@"#ffffff" font:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:self.rightButton];
    }
    self.rightButton.frame = CGRectMake(kIuleScreenW - width - 10, 0, width, 44);
}

- (void)setRightButtonTitleColor:(NSString *)rightButtonTitleColor {
    [self.rightButton setTitleColor:[UIColor ly_colorWithHexString:rightButtonTitleColor] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor ly_colorWithHexString:rightButtonTitleColor] forState:UIControlStateHighlighted];
}

- (void)setRightButtonImage:(NSString *)rightButtonImage {
    _rightButtonImage = rightButtonImage;
    if (self.rightButton) {
        [self.rightButton setImage:[UIImage imageNamed:rightButtonImage] forState:UIControlStateNormal];
    }else {
        self.rightButton = [UIButton ly_buttonWithImage:rightButtonImage];
        self.rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
        self.rightButton.frame = CGRectMake(kIuleScreenW - 60, 0, 60, 44);
        [self.contentView addSubview:self.rightButton];
    }
}

- (void)setRightButton:(UIButton *)rightButton {
    _rightButton = rightButton;
    self.rightButton.frame = CGRectMake(kIuleScreenW - rightButton.ly_width - 10, 0, rightButton.ly_width, rightButton.ly_height);
    self.rightButton.center = CGPointMake(self.rightButton.center.x, 22);
    [self.contentView addSubview:self.rightButton];
}

- (void)setTitleView:(UIView *)titleView {
    _titleView = titleView;
    [self.contentView addSubview:self.titleView];
//    CGFloat leftWidth = self.leftButton.hidden ? 0 : 32;
    CGFloat centerX = kIuleScreenW / 2.0;
    if (self.rightButton) {
    }
    self.titleView.center = CGPointMake(centerX, 22);
}

- (void)addCustemView:(UIView *)custemView {
    [self.contentView addSubview:custemView];
}

- (void)addBackgroundCustemView:(UIView *)custemView {
    custemView.frame = self.bounds;
    [self addSubview:custemView];
    [self sendSubviewToBack:custemView];
}

#pragma mark -
#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(0, self.ly_height - 44, kIuleScreenW, 44);
    self.lineView.frame = CGRectMake(0, self.contentView.ly_height - kIuleLineH, kIuleScreenW, kIuleLineH);
    self.titleLabel.frame = CGRectMake(0, 0, kIuleScreenW - 60 * 2, 44);
    self.titleLabel.center = CGPointMake(kIuleScreenW / 2.0, 22);
    self.leftButton.frame = CGRectMake(0, 0, 32, 44);
}

#pragma mark
#pragma mark -- UI

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor ly_colorWithHexString:@"#EEEEEE"];
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel ly_labelWithFont:[UIFont boldSystemFontOfSize:16] textColor:@"#333333" textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton ly_buttonWithImage:@"iule_ic_back"];
    }
    return _leftButton;
}

@end
