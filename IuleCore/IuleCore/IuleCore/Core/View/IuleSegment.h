//
//  IuleSegment.h
//  xmxxds
//
//  Created by wangyang on 2020/1/20.
//  Copyright © 2020 iule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *IuleSegmentNormalColor = @"IuleSegmentNormalColor";
static NSString *IuleSegmentSelectedColor= @"IuleSegmentSelectedColor";
static NSString *IuleSegmentNormalFont = @"IuleSegmentNormalFont";
static NSString *IuleSegmentSelectedFont= @"IuleSegmentSelectedFont";


@class IuleSegment;

@protocol IuleSegmentDelegate <NSObject>
@optional

- (void)segment:(IuleSegment *)segment didSelectedAtIndex:(NSInteger)index;

@end


@interface IuleSegment : UIView
@property (nonatomic, assign) BOOL showBottomLine;//是否显示移动横线
@property (nonatomic, assign) CGFloat lineWidth;//底部横线宽度
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;//item间隔
@property (nonatomic, assign) UIEdgeInsets sectionInset;//
@property (nonatomic, strong) NSDictionary *attributedDic;//{LYSegmentNormalColor,LYSegmentSelectedColor,LYSegmentNormalFont,LYSegmentSelectedFont}
@property (nonatomic, assign) BOOL autoAdjustCellWidth;//自动调整大小


@property (nonatomic, assign) NSInteger selectIndex;

@property (strong, nonatomic, readonly) NSMutableArray *segments;

- (instancetype)initWithFrame:(CGRect)frame
                     segments:(NSArray *)segments
                     delegate:(id <IuleSegmentDelegate>)delegate;

- (instancetype)initWithFrame:(CGRect)frame
                 sectionInset:(UIEdgeInsets)sectionInset
                     segments:(NSArray *)segments
                     delegate:(id <IuleSegmentDelegate>)delegate;

- (void)reloadSegmentWithArray:(NSArray *)array;

- (void)moveCellWithIndex:(NSInteger)index;

- (void)addBottomLineWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
