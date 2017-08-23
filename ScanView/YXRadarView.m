//
//  YXRadarView.m
//  YXRadarScanDemo
//
//  Created by bai on 16/10/10.
//  Copyright © 2016年 bai. All rights reserved.
//

#import "YXRadarView.h"
#import "YXRadarIndictorView.h"
#import "lodingPointCGPoint.h"

#define RADAR_DEFAULT_SECTIONS_NUM 4
#define RADAR_DEFAULT_RADIUS 100.f
#define RADAR_ROTATE_SPEED 60.f
#define INDICATOR_START_COLOR [UIColor colorWithRed:0.0/255.0 green:190.0/255.0 blue: 164.0/255.0 alpha:51.0/255.0]
#define INDICATOR_END_COLOR [UIColor colorWithRed:250.0/255.0 green:250.0/255.0 blue: 250.0/255.0 alpha:0]
#define INDICATOR_ANGLE 360.0f
#define INDICATOR_CLOCKWISE YES

@implementation YXRadarView

static NSString * const rotationAnimationKey = @"rotationAnimation";

#pragma mark - life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    if(!self.pointsView)
    {
        CGRect frames = CGRectMake(0, 0, ((self.frame.size.width)/2), ((self.frame.size.width)/2));
        
        YXRadarPointView *pointsView = [[YXRadarPointView alloc] initWithFrame:frames :[self getThreePoint]];
        
        pointsView.center = self.center;
        
        [self addSubview:pointsView];
        
        self.pointsView = pointsView;
        
        self.pointsView.backgroundColor = [UIColor clearColor];
    }
    
    if (!self.indicatorView)
    {
        YXRadarIndictorView *indicatorView = [[YXRadarIndictorView alloc] initWithFrame:self.bounds];
        [self addSubview:indicatorView];
        self.indicatorView = indicatorView;
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 画布
    CGContextRef context =  UIGraphicsGetCurrentContext();
    // 背景图片
    if (self.backgroundImage) {
        UIImage *image = self.backgroundImage;
        [image drawInRect:self.bounds]; // 画出图片
    }
    
    NSInteger sectionsNum = RADAR_DEFAULT_SECTIONS_NUM;
//    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInRadarView:)]) {
//        sectionsNum = [self.dataSource numberOfSectionsInRadarView:self];
//    }
    
    CGFloat radius = RADAR_DEFAULT_RADIUS;
    if (_radius) {
        radius = _radius;
    }
    
    CGFloat indicatorAngle = INDICATOR_ANGLE;
    if (self.indicatorAngle) {
        indicatorAngle = self.indicatorAngle;
    }
    
    BOOL indicatorClockwise = INDICATOR_CLOCKWISE;
    if (self.indicatorClockwise) {
        indicatorClockwise = self.indicatorClockwise;
    }
    
    UIColor *indicatorStartColor = INDICATOR_START_COLOR;
    if (self.indicatorStartColor) {
        indicatorStartColor = self.indicatorStartColor;
    }
    
    UIColor *indicatorEndColor = INDICATOR_END_COLOR;
    if (self.indicatorEndColor) {
        indicatorEndColor = self.indicatorEndColor;
    }
    
    
    // 画图坐标轴
    
    CGContextMoveToPoint(context, 0, self.bounds.size.height * 0.5);
    CGContextSetRGBStrokeColor(context, 0.0f/255.0f, 190.0f/255.0f, 164.0f/255.0f,1); //
    CGContextSetLineWidth(context, 1.0);    // 线宽
    
//    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height * 0.5);
//    CGContextMoveToPoint(context, self.bounds.size.width * 0.5, (self.bounds.size.height-self.bounds.size.width)*0.5);
//    CGContextAddLineToPoint(context, self.bounds.size.width * 0.5, self.bounds.size.height - (self.bounds.size.height-self.bounds.size.width)*0.5);
    
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);

    CGFloat sectionRadius = 0.0f;
    
    for (int i = 0; i < sectionsNum; i++)
    {
        // 画圈
        sectionRadius = [self getCircleRadius:i :_radius];
//        NSLog(@"sectionRadius - %f",sectionRadius);
        CGContextSetLineWidth(context, 1.0);    // 线宽
        CGContextAddArc(context, self.center.x, self.center.y, sectionRadius, 0, 2*M_PI, 0);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    
    if (self.indicatorView)
    {
        self.indicatorView.frame = self.bounds;
        self.indicatorView.backgroundColor = [UIColor clearColor];
        self.indicatorView.radius = (_radius * 6)/7.0f;
        self.indicatorView.angle = indicatorAngle;
        self.indicatorView.clockwise = indicatorClockwise;
        self.indicatorView.startColor = indicatorStartColor;
        self.indicatorView.endColor = indicatorEndColor;
    }
}

-(float)getCircleRadius:(int)num :(float)radius
{
    float CircleRadius = 0.0f;
    
    switch (num)
    {
        case 0:
            CircleRadius = (radius * 6)/7.0f;
            break;
        case 1:
            CircleRadius = (radius * 2)/7.0f;
            break;
        case 2:
            CircleRadius = (radius * 2)/4.0f;
            break;
        case 3:
            CircleRadius = (radius * 2)/3.0f;
            break;
        case 4:
            CircleRadius = (radius * 6)/7.0f;
            break;
            
        default:
            break;
    }
    
    return CircleRadius;
}

#pragma mark - Actions
- (void)scan
{
    CABasicAnimation *rotationAnimation;
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    BOOL indicatorClockwise = INDICATOR_CLOCKWISE;
    
    if (self.indicatorClockwise)
    {
        indicatorClockwise = self.indicatorClockwise;
    }
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:(indicatorClockwise?1:-1) * M_PI * 4.0];
    rotationAnimation.duration = 360.f / RADAR_ROTATE_SPEED;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INT_MAX;
    
//    rotationAnimation.fillMode = kCAFillModeForwards;
//    rotationAnimation.removedOnCompletion = NO;
    
    [self.indicatorView.layer addAnimation:rotationAnimation forKey:rotationAnimationKey];
    
    [self show];
}

- (void)timerFire:(NSTimer *)timer
{
//    NSLog(@"画点");
    [self.pointsView refreshView:[self getThreePoint]];
}

-(NSMutableArray *)getThreePoint
{
    int point_width = self.frame.size.width/2;
    int point_height = self.frame.size.width/2;
    
//    NSLog(@"%d - %d",point_width,point_height);
    
    NSMutableArray *pointArrys = [NSMutableArray array];
    
    int nums = 1 + (arc4random()%3);
    
    for (int i = 0; i < nums; i++)
    {
        //随机创建三个点
        float width_point =  ((10 +(arc4random()%80)) * point_width) / 100.0f;
        float height_point = ((10 +(arc4random()%80)) * point_height) / 100.0f;
        int radius_point = 4 + (arc4random()%2);
        int check_point = (arc4random()%2);
        
        lodingPointCGPoint *points = [[lodingPointCGPoint alloc] init];
        
        points.point_x_w = width_point;
        points.point_y_h = height_point;
        points.radius_point = radius_point;
        points.check_point = check_point;
        
        [pointArrys addObject:points];
    }
    
    return pointArrys;
}

//停止
- (void)stop
{
    if (_timers)
    {
        [_timers invalidate];
        _timers = nil;
        [self.indicatorView.layer removeAnimationForKey:rotationAnimationKey];
    }
}

- (void)show
{
    //添加随机出现的点
     _timers = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
    
    // 时间转换
    CFTimeInterval pauseTime = self.indicatorView.layer.timeOffset;
    // 计算暂停时间
    CFTimeInterval timeSincePause = CACurrentMediaTime() - pauseTime;
    // 取消
    self.indicatorView.layer.timeOffset = 0;
    // local time相对于parent time世界的beginTime
    self.indicatorView.layer.beginTime = timeSincePause;
    // 继续
    self.indicatorView.layer.speed = 1;
}

//暂停
- (void)hide
{
    [_timers invalidate];
    _timers = nil;
    
    // 将当前时间CACurrentMediaTime转换为layer上的时间, 即将parent time转换为local time
    CFTimeInterval pauseTime = [self.indicatorView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    // 设置layer的timeOffset, 在继续操作也会使用到
    self.indicatorView.layer.timeOffset = pauseTime;
    
    self.indicatorView.layer.speed = 0;
}
@end
