//
//  ScanViewViewController.m
//  ScanView
//
//  Created by tyz on 17/8/23.
//  Copyright © 2017年 tyz. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#import "ScanViewViewController.h"
#import "YXRadarView.h"
#import "YXRadarIndictorView.h"

@interface ScanViewViewController ()
{
    int animation_status;   //0 - 停止  1 - 旋转
    int check_nums;   //判断是否已经绑定
    NSTimer *scanTimer;
}

@end

@implementation ScanViewViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    animation_status = 1;
    
    [self setupRadarView];
}

- (void)setupRadarView
{
    YXRadarView *radarView = [[YXRadarView alloc] initWithFrame:self.view.bounds];
    //    radarView.radius = 150;
    radarView.radius = (SCREEN_WIDTH - 20.0f)/2;
    radarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:radarView];
    self.radarView = radarView;
    
    // 目标点位置
    [self.radarView scan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
