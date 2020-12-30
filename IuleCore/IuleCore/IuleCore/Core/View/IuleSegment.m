//
//  IuleSegment.m
//  xmxxds
//
//  Created by wangyang on 2020/1/20.
//  Copyright © 2020 iule. All rights reserved.
//

#import "IuleSegment.h"
#import "UIColor+LYHex.h"
#import "UIView+LYCategory.h"

@interface LYSegmentCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *contentLabel;
+ (CGFloat)cellHeightWithStr:(NSString *)str;
@end

@implementation LYSegmentCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

+ (CGFloat)cellHeightWithStr:(NSString *)str {
    LYSegmentCell *cell = [LYSegmentCell new];
    UILabel *label = cell.contentLabel;
    CGFloat width = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, label.font.lineHeight) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size.width;
    width = ceil(width);
    return width + 15 * 2;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = [UIColor ly_colorWithHexString:@"#8A8A8A"];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

@end

@interface IuleSegment ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *segments;

@property (nonatomic, weak) id <IuleSegmentDelegate> delegate;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) CALayer *bottomLayer;

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, strong) UIFont *selectedFont;
@end

@implementation IuleSegment

- (instancetype)initWithFrame:(CGRect)frame
                 sectionInset:(UIEdgeInsets)sectionInset
                     segments:(NSArray *)segments
                     delegate:(id <IuleSegmentDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoAdjustCellWidth = NO;
        self.sectionInset = sectionInset;
        self.minimumInteritemSpacing = 0;
        self.selectIndex = 0;
        self.segments = segments.mutableCopy;
        self.delegate = delegate;
        self.normalColor = [UIColor ly_colorWithHexString:@"#FFFFFF"];
        self.selectedColor = [UIColor ly_colorWithHexString:@"#FFFFFF"];
        self.normalFont = [UIFont systemFontOfSize:14];
        self.selectedFont = [UIFont boldSystemFontOfSize:14];
        self.showBottomLine = YES;
        [self.collectionView reloadData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                     segments:(NSArray *)segments
                     delegate:(id<IuleSegmentDelegate>)delegate {
    return [self initWithFrame:frame sectionInset:UIEdgeInsetsMake(0, 5, 0, 5) segments:segments delegate:delegate];
}

#pragma mark
#pragma mark -- pravate method

- (void)reloadSegmentWithArray:(NSArray *)array {
    self.segments = array.mutableCopy;
    [self.collectionView reloadData];
}

- (void)moveCellWithIndex:(NSInteger)index {
    self.selectIndex = index;
    if (self.autoAdjustCellWidth) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    [self.collectionView reloadData];
}

- (void)addBottomLineWithColor:(UIColor *)color {
    self.bottomLayer.backgroundColor = color.CGColor;
}

- (void)setShowBottomLine:(BOOL)showBottomLine {
    _showBottomLine = showBottomLine;
    [self.collectionView reloadData];
}

- (void)setAttributedDic:(NSDictionary *)attributedDic {
    _attributedDic = attributedDic;
    if (attributedDic[IuleSegmentNormalColor]) {
        self.normalColor = attributedDic[IuleSegmentNormalColor];
    }
    if (attributedDic[IuleSegmentNormalFont]) {
        self.normalFont = attributedDic[IuleSegmentNormalFont];
    }
    if (attributedDic[IuleSegmentSelectedColor]) {
        self.selectedColor = attributedDic[IuleSegmentSelectedColor];
    }
    if (attributedDic[IuleSegmentSelectedFont]) {
        self.selectedFont = attributedDic[IuleSegmentSelectedFont];
    }
    [self.collectionView reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.bottomLayer.frame = CGRectMake(0, self.ly_height - 1, self.ly_width, 1);
}

#pragma mark
#pragma mark -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.segments.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LYSegmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LYSegmentCell" forIndexPath:indexPath];
    NSString *obj = self.segments[indexPath.row];
    cell.contentLabel.text = obj;
    if (self.selectIndex == indexPath.row) {
        cell.contentLabel.textColor = self.selectedColor;
        cell.contentLabel.font = self.selectedFont;
        if (self.showBottomLine) {
            __weak typeof(self) weakSelf = self;
            [UIView animateWithDuration:0.25 animations:^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                CGRect bounds = CGRectMake(0, 0, strongSelf.lineWidth, strongSelf.lineView.ly_height);
                if (strongSelf.lineWidth > 0) {
                    bounds = CGRectMake(0, 0, strongSelf.lineWidth, strongSelf.lineView.ly_height);
                }else {
                    bounds = CGRectMake(0, 0, cell.ly_width - 2 * 10, strongSelf.lineView.ly_height);
                }
                strongSelf.lineView.bounds = bounds;
                strongSelf.lineView.center = CGPointMake(cell.frame.origin.x + cell.frame.size.width / 2.0, cell.frame.size.height - strongSelf.lineView.ly_height / 2.0 - 5);
            } completion:^(BOOL finished) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                strongSelf.lineView.hidden = NO;
            }];
        }
    }else {
        cell.contentLabel.textColor = self.normalColor;
        cell.contentLabel.font = self.normalFont;
    }
    return cell;
}

#pragma mark
#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [self moveCellWithIndex:indexPath.row];
    self.selectIndex = indexPath.item;
    if ([self.delegate respondsToSelector:@selector(segment:didSelectedAtIndex:)]) {
        [self.delegate segment:self didSelectedAtIndex:self.selectIndex];
    }
}

#pragma mark
#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.autoAdjustCellWidth) {
        NSString *obj = self.segments[indexPath.row];
        CGFloat width = [LYSegmentCell cellHeightWithStr:obj];
        CGFloat height = collectionView.frame.size.height;
        return CGSizeMake(width, height);
    }else {
        CGFloat height = collectionView.frame.size.height;
        CGFloat width = (collectionView.ly_width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing) / self.segments.count;
        return CGSizeMake(width, height);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.sectionInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark
#pragma mark -- lazy

- (NSMutableArray *)segments {
    if (!_segments) {
        _segments = @[].mutableCopy;
    }
    return _segments;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 18, 4)];
        _lineView.backgroundColor = [UIColor ly_colorWithHexString:@"#F75305"];
        [_lineView ly_cornerWithRadius:_lineView.ly_height / 2.0];
        _lineView.hidden = YES;
        [self.collectionView addSubview:_lineView];
    }
    return _lineView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = self.backgroundColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[LYSegmentCell class] forCellWithReuseIdentifier:NSStringFromClass([LYSegmentCell class])];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (CALayer *)bottomLayer {
    if (!_bottomLayer) {
        _bottomLayer = [[CALayer alloc] init];
        _bottomLayer.backgroundColor = self.backgroundColor.CGColor;
        [self.layer addSublayer:_bottomLayer];
    }
    return _bottomLayer;
}

@end
