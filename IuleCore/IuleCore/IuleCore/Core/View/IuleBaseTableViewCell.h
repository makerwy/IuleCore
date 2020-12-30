//
//  IuleBaseTableViewCell.h
//  IuleCore
//
//  Created by mac on 2020/5/22.
//  Copyright © 2020 iule. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IuleBaseModel;

NS_ASSUME_NONNULL_BEGIN

@interface IuleBaseTableViewCell : UITableViewCell

+ (CGFloat)cellHeightWithModel:(nullable IuleBaseModel *)model;

- (void)layoutCellWithModel:(nullable IuleBaseModel *)model;

@end

NS_ASSUME_NONNULL_END
