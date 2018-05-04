//
//  LDSegmentBar.h
//  LDSegmentBarVc
//
//  Created by 李洞洞 on 4/5/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDSegmentBar;
@protocol LDSegmentBarDelegate <NSObject>
/**
 代理方法, 告诉外界, 内部的点击数据
 
 @param segmentBar segmentBar
 @param toIndex    选中的索引(从0开始)
 @param fromIndex  上一个索引
 */
- (void)segmentBar: (LDSegmentBar *)segmentBar didSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex;
@end
@interface LDSegmentBar : UIView
/**
 快速创建一个选项卡控件
 
 @param frame frame
 
 @return 选项卡控件
 */
+ (instancetype)segmentBarWithFrame: (CGRect)frame;

/** 代理 */
@property (nonatomic, weak) id<LDSegmentBarDelegate> delegate;

/** 数据源 */
@property (nonatomic, strong) NSArray <NSString *>*items;

/** 当前选中的索引, 双向设置 */
@property (nonatomic, assign) NSInteger selectIndex;


@end
