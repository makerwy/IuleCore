//
//  IuleBaseTableViewCell.m
//  IuleCore
//
//  Created by mac on 2020/5/22.
//  Copyright © 2020 iule. All rights reserved.
//

#import "IuleBaseTableViewCell.h"

@implementation IuleBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (CGFloat)cellHeightWithModel:(nullable IuleBaseModel *)model {
    return 0;
}

- (void)layoutCellWithModel:(nullable IuleBaseModel *)model {
    
}

@end
