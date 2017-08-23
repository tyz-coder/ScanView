//
//  YXRadarPointView.m
//  YXRadarScanDemo
//
//  Created by bai on 16/10/10.
//  Copyright © 2016年 bai. All rights reserved.
//

#import "YXRadarPointView.h"
#import "lodingPointCGPoint.h"

#define lightColor [UIColor colorWithRed:0.0/255.0 green:190.0/255.0 blue: 164.0/255.0 alpha:1]
#define blackColor [UIColor colorWithRed:0.0/255.0 green:190.0/255.0 blue: 164.0/255.0 alpha:85.0/255.0]

@implementation YXRadarPointView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame :(NSMutableArray *)setArrys
{
    self = [self initWithFrame:frame];
    
    _array_pointData = [NSMutableArray array];
    _array_pointData = setArrys;
    
    if (self)
    {
        
    }
    return self;
}

//绘制背景
- (void)drawRect:(CGRect)rect
{
    //画一个圆
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (_array_pointData)
    {
        for(lodingPointCGPoint *lodingPoint in _array_pointData)
        {
            float width_point = lodingPoint.point_x_w;
            float height_point = lodingPoint.point_y_h;
            int radius_point = lodingPoint.radius_point;
            int check_point = lodingPoint.check_point;
            
            //填充颜色
            if (check_point == 1)
            {
                CGContextSetFillColorWithColor(context, lightColor.CGColor);
            }
            else
            {
                CGContextSetFillColorWithColor(context, blackColor.CGColor);
            }
            
            //添加一个圆
            CGContextAddArc(context, width_point,height_point,radius_point, 0, 2*M_PI, 0);
            //绘制填充
            CGContextDrawPath(context, kCGPathFill);
        }

    }
    
    CGContextStrokePath(context);
}

//刷新界面
-(void)refreshView:(NSMutableArray *)arrys
{
    _array_pointData = [NSMutableArray array];
    
    _array_pointData = arrys;
    
    [self setNeedsDisplay];
}


@end
