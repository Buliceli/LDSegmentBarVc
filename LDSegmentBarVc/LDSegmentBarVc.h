//
//  LDSegmentBarVc.h
//  LDSegmentBarVc
//
//  Created by 李洞洞 on 4/5/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDSegmentBar.h"
@interface LDSegmentBarVc : UIViewController
@property(nonatomic,weak)LDSegmentBar * segmentBar;
- (void)setUpWithItems: (NSArray <NSString *>*)items childVCs: (NSArray <UIViewController *>*)childVCs;
@end
