//
//  ViewController.m
//  ZYClock
//
//  Created by Palmpay on 2018/5/31.
//  Copyright © 2018年 palm. All rights reserved.
//

#import "ViewController.h"

//每一秒旋转的度数
#define perSecA 6

//每一分旋转的度数
#define perMinA 6

//每一小时旋转的度数
#define perHourA 30

//每一分时针旋转的度数
#define perMinHourA 0.5

#define angle2Rad(angle) ((angle) / 180.0 * M_PI)

@interface ViewController ()
//钟表
@property (weak, nonatomic) IBOutlet UIImageView *clockView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) CALayer *secL;

@property (nonatomic, weak) CALayer *minL;

@property (nonatomic, weak) CALayer *hourL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加秒针
    [self setSec];
    //添加分针
    [self setMin];
    //添加时针
    [self setHour];
    //监测时间的改变
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self timeChange];
}

#pragma mark -- 更新时间
- (void)timeChange {
    //日历
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [cal components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour  fromDate:[NSDate date]];
    NSInteger curSec = cmp.second + 1;
    CGFloat secA = curSec *perSecA;
    self.secL.transform = CATransform3DMakeRotation(angle2Rad(secA), 0, 0, 1);
    
    NSInteger curMin = cmp.minute;
    CGFloat minA = curMin *perMinA;
    self.minL.transform = CATransform3DMakeRotation(angle2Rad(minA), 0, 0, 1);
    
    NSInteger curHour = cmp.hour;
    CGFloat hourA = curHour *perHourA + curMin *perMinHourA;
    self.hourL.transform = CATransform3DMakeRotation(angle2Rad(hourA), 0, 0, 1);
    
}

#pragma mark -- 添加秒针
- (void)setSec {
    CALayer *secLayer = [CALayer layer];
    secLayer.bounds = CGRectMake(0, 0, 1, 80);
    secLayer.position = CGPointMake(self.clockView.bounds.size.width *0.5, self.clockView.bounds.size.height *0.5);
    secLayer.anchorPoint = CGPointMake(0.5, 1);
    secLayer.backgroundColor = [UIColor redColor].CGColor;
    secLayer.cornerRadius = 0.5;
    [self.clockView.layer addSublayer:secLayer];
    self.secL = secLayer;
}

#pragma mark -- 添加分针
- (void)setMin {
    CALayer *minLayer = [CALayer layer];
    minLayer.bounds = CGRectMake(0, 0, 3, 70);
    minLayer.position = CGPointMake(self.clockView.bounds.size.width *0.5, self.clockView.bounds.size.height *0.5);
    minLayer.anchorPoint = CGPointMake(0.5, 1);
    minLayer.backgroundColor = [UIColor blackColor].CGColor;
    minLayer.cornerRadius = 1.5;
    [self.clockView.layer addSublayer:minLayer];
    self.minL = minLayer;
}

- (void)setHour {
    CALayer *hourLayer = [CALayer layer];
    hourLayer.bounds = CGRectMake(0, 0, 3, 50);
    hourLayer.position = CGPointMake(self.clockView.bounds.size.width *0.5, self.clockView.bounds.size.height *0.5);
    hourLayer.anchorPoint = CGPointMake(0.5, 1);
    hourLayer.backgroundColor = [UIColor blackColor].CGColor;
    hourLayer.cornerRadius = 1.5;
    [self.clockView.layer addSublayer:hourLayer];
    self.hourL = hourLayer;
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
