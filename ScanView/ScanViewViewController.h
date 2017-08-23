//
//  ScanViewViewController.h
//  ScanView
//
//  Created by tyz on 17/8/23.
//  Copyright © 2017年 tyz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXRadarView;

@interface ScanViewViewController : UIViewController

@property (nonatomic, weak) YXRadarView *radarView;
@property (nonatomic, strong) NSMutableArray *pointsArray;
@property (nonatomic, strong) NSTimer *timer;

@end
