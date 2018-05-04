//
//  ScanButton.h
//  MinTeMatch
//
//  Created by 李洞洞 on 30/8/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XMGExtension)
@property (nonatomic, assign) CGSize xmg_size;
@property (nonatomic, assign) CGFloat xmg_width;
@property (nonatomic, assign) CGFloat xmg_height;
@property (nonatomic, assign) CGFloat xmg_x;
@property (nonatomic, assign) CGFloat xmg_y;
@property (nonatomic, assign) CGFloat xmg_centerX;
@property (nonatomic, assign) CGFloat xmg_centerY;

@property (nonatomic, assign) CGFloat xmg_right;
@property (nonatomic, assign) CGFloat xmg_bottom;

+ (instancetype)viewFromXib;

- (BOOL)intersectWithView:(UIView *)view;
@end
