//
//  LDSegmentBarVc.m
//  LDSegmentBarVc
//
//  Created by 李洞洞 on 4/5/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import "LDSegmentBarVc.h"
#import "UIView+XMGExtension.h"
@interface LDSegmentBarVc ()<LDSegmentBarDelegate, UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation LDSegmentBarVc
- (LDSegmentBar *)segmentBar
{
    if (!_segmentBar) {
        LDSegmentBar * segmentBar = [LDSegmentBar segmentBarWithFrame:CGRectZero];
        segmentBar.delegate = self;
        segmentBar.backgroundColor = [UIColor brownColor];
        [self.view addSubview:segmentBar];
        _segmentBar = segmentBar;
    }
    return _segmentBar;
}
- (UIScrollView *)contentView {
    if (!_contentView) {
        
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.delegate = self;
        contentView.pagingEnabled = YES;
        [self.view addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)setUpWithItems:(NSArray<NSString *> *)items childVCs:(NSArray<UIViewController *> *)childVCs
{
    NSAssert(items.count != 0 || items.count == childVCs.count, @"个数不一致, 请自己检查");
    self.segmentBar.items = items;
    
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    // 添加几个自控制器
    // 在contentView, 展示子控制器的视图内容
    for (UIViewController *vc in childVCs) {
        [self addChildViewController:vc];
    }
    
    //
    self.contentView.contentSize = CGSizeMake(items.count * self.view.xmg_width, 0);
    
    self.segmentBar.selectIndex = 0;
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (self.segmentBar.superview == self.view) {
        self.segmentBar.frame = CGRectMake(0, 20, self.view.xmg_width, 35);
        CGFloat contentViewY = self.segmentBar.xmg_y + self.segmentBar.xmg_height;
        CGRect contentFrame = CGRectMake(0, contentViewY, self.view.xmg_width, self.view.xmg_height - contentViewY);
        self.contentView.frame = contentFrame;
        self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.xmg_width, 0);
        
        return;
        
    }
    
    CGRect contentFrame = CGRectMake(0, 0,self.view.xmg_width,self.view.xmg_height);
    self.contentView.frame = contentFrame;
    self.contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.xmg_width, 0);
}
#pragma mark - 选项卡代理方法
- (void)segmentBar:(LDSegmentBar *)segmentBar didSelectIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"%zd----%zd", fromIndex, toIndex);
    [self showChildVCViewsAtIndex:toIndex];
}
- (void)showChildVCViewsAtIndex: (NSInteger)index {
    
    if (self.childViewControllers.count == 0 || index < 0 || index > self.childViewControllers.count - 1) {
        return;
    }
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * self.contentView.xmg_width, 0, self.contentView.xmg_width, self.contentView.xmg_height);
    [self.contentView addSubview:vc.view];
    
    // 滚动到对应的位置
    [self.contentView setContentOffset:CGPointMake(index * self.contentView.xmg_width, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 计算最后的索引
    NSInteger index = self.contentView.contentOffset.x / self.contentView.xmg_width;
    
    //    [self showChildVCViewsAtIndex:index];
    self.segmentBar.selectIndex = index;
    
}
@end
