//
//  TestController.m
//  LDSegmentBarVc
//
//  Created by 李洞洞 on 4/5/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import "TestController.h"

@interface TestController ()

@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * subView = ({
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
        view.backgroundColor = [UIColor purpleColor];
        view;
    });
    [self.view addSubview:subView];
}

@end
