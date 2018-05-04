//
//  ViewController.m
//  LDSegmentBarVc
//
//  Created by 李洞洞 on 4/5/18.
//  Copyright © 2018年 Minte. All rights reserved.
//

#import "ViewController.h"
#import "LDSegmentBarVc.h"
#import "TestController.h"
@interface ViewController ()
@property(nonatomic,strong)LDSegmentBarVc * segmentBarVC;
@end

@implementation ViewController
- (LDSegmentBarVc *)segmentBarVC
{
    if (!_segmentBarVC) {
        LDSegmentBarVc * vc = [[LDSegmentBarVc alloc]init];
        [self addChildViewController:vc];
        _segmentBarVC = vc;
    }
    return _segmentBarVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.segmentBarVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentBarVC.view];
    NSArray *items = @[@"专辑", @"声音", @"下载中"];
    
    TestController *vc1 = [TestController new];
    vc1.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor yellowColor];
    
    
    [self.segmentBarVC setUpWithItems:items childVCs:@[vc1, vc2, vc3]];
}


@end
