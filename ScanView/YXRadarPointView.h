//
//  YXRadarPointView.h
//  YXRadarScanDemo
//
//  Created by bai on 16/10/10.
//  Copyright © 2016年 bai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXRadarPointView : UIView

@property (nonatomic, retain)NSMutableArray *array_pointData;    //画点数据

//初始化设置
-(id)initWithFrame:(CGRect)frame :(NSMutableArray *)setArrys;

//刷新界面
-(void)refreshView:(NSMutableArray *)arrys;

@end
