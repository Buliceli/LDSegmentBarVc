//
//  LDSegmentBar.m
//  LDSegmentBarVc
//
//  Created by 李洞洞 on 4/5/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import "LDSegmentBar.h"
#import "UIView+XMGExtension.h"
#define kMinMargin 30
@interface LDSegmentBar ()
{
/**记录最后一次点击的按钮*/
    UIButton * _lastBtn;
}
/** 内容承载视图 */
@property (nonatomic, weak) UIScrollView *contentView;

/** 添加的按钮数据 */
@property (nonatomic, strong) NSMutableArray <UIButton *>*itemBtns;
/** 指示器 */
@property (nonatomic, weak) UIView *indicatorView;

@end
@implementation LDSegmentBar
#pragma mark - 懒加载
- (NSMutableArray<UIButton *> *)itemBtns {
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}
- (UIView *)indicatorView {
    if (!_indicatorView) {
        CGFloat indicatorH = 2;
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.xmg_height - indicatorH, 0, indicatorH)];
        indicatorView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _contentView = scrollView;
    }
    return _contentView;
}
+ (instancetype)segmentBarWithFrame:(CGRect)frame
{
    LDSegmentBar * segmentBar = [[LDSegmentBar alloc]initWithFrame:frame];
    return segmentBar;
}
- (void)setItems:(NSArray<NSString *> *)items
{
    _items = items;
    /**删除之前添加的组件*/
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    // 根据所有的选项数据源， 创建Button, 添加到内容视图
    for (NSString *item in items) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = self.itemBtns.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitle:item forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    // 手动刷新布局
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)setSelectIndex:(NSInteger)selectIndex {
    // 数据过滤
    if (self.itemBtns.count == 0 || selectIndex < 0 || selectIndex > self.itemBtns.count - 1) {
        return;
    }
    _selectIndex = selectIndex;
    UIButton *btn = self.itemBtns[selectIndex];
    [self btnClick:btn];
}
- (void)btnClick: (UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectIndex:fromIndex:)]) {
        [self.delegate segmentBar:self didSelectIndex:btn.tag fromIndex:_lastBtn.tag];
    }
    _selectIndex = btn.tag;
    
    _lastBtn.selected = NO;
    btn.selected = YES;
    _lastBtn = btn;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.xmg_width = btn.xmg_width;
        self.indicatorView.xmg_centerX = btn.xmg_centerX;
    }];
    
    CGFloat scrollX = btn.xmg_centerX - self.contentView.xmg_width * 0.5;
    
    if (scrollX < 0) {
        scrollX = 0;
    }
    if (scrollX > self.contentView.contentSize.width - self.contentView.xmg_width) {
        scrollX = self.contentView.contentSize.width - self.contentView.xmg_width;
    }
    
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
}
#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = self.bounds;
    // 计算margin
    CGFloat totalBtnWidth = 0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        totalBtnWidth += btn.xmg_width;
    }
    CGFloat caculateMargin = (self.xmg_width - totalBtnWidth) / (self.items.count + 1);
    if (caculateMargin < kMinMargin) {
        caculateMargin = kMinMargin;
    }
    CGFloat lastX = caculateMargin;
    for (UIButton *btn in self.itemBtns) {
        // w, h
        [btn sizeToFit];
        // y 0
        // x, y,
        btn.xmg_y = 0;
        
        btn.xmg_x = lastX;
        
        lastX += btn.xmg_width + caculateMargin;
        
    }
    self.contentView.contentSize = CGSizeMake(lastX, 0);
    if (self.itemBtns.count == 0) {
        return;
    }
    UIButton *btn = self.itemBtns[self.selectIndex];
    self.indicatorView.xmg_width = btn.xmg_width;
    self.indicatorView.xmg_centerX = btn.xmg_centerX;
    self.indicatorView.xmg_height = 2;
    self.indicatorView.xmg_y = self.xmg_height - self.indicatorView.xmg_height;
}
@end
