//
//  YXRadarView.h
//  YXRadarScanDemo
//
//  Created by bai on 16/10/10.
//  Copyright © 2016年 bai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXRadarPointView.h"

@class YXRadarIndictorView;

@protocol YXRadarViewDelegate;
@protocol YXRadarViewDateSource;

@interface YXRadarView : UIView
{
//@private
//    NSTimer *_timers; //随机出现点
//    CGFloat _radius;   // 半径
}

@property (nullable, nonatomic,strong) NSTimer *timers; //随机出现点
@property (nonatomic, assign) CGFloat radius;  // 半径
@property(nullable, nonatomic,strong) UIColor *indicatorStartColor; // 开始颜色
@property(nullable, nonatomic,strong) UIColor *indicatorEndColor;   // 结束颜色
@property (nonatomic, assign) CGFloat indicatorAngle;   // 扇形角度
@property (nonatomic, assign) BOOL indicatorClockwise;  // 是否顺时针
@property(nullable, nonatomic,strong) UIImage *backgroundImage; // 背景图片
@property(nullable, nonatomic,strong) YXRadarPointView *pointsView;   // 目标点视图
@property(nullable, nonatomic,strong) YXRadarIndictorView *indicatorView;   // 扫描指针

@property(nullable, nonatomic,weak) id<YXRadarViewDateSource> dataSource;   // 数据源
@property(nullable, nonatomic,weak) id<YXRadarViewDelegate> delegate;   // 委托

- (void)scan;   // 扫描
- (void)stop;   // 停止
- (void)show;   // 显示目标
- (void)hide;   // 隐藏目标

@end

