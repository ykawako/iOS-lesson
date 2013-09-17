//
//  TimeViewController.m
//  私の今を知る
//
//  Created by 河原 on 2013/09/03.
//  Copyright (c) 2013年 河原. All rights reserved.
//

#import "TimeViewController.h"

@interface TimeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) NSString *timerSetting;
@property (nonatomic) NSDateFormatter *timeFormat;
@end

@implementation TimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

     _timeFormat= [[NSDateFormatter alloc] init];
    [_timeFormat setDateFormat:@"HH:mm:ss"];
    [_timeFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];

    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(timerCall:)
                                           userInfo:nil
                                            repeats:YES
             ];
    
    [self timerSet];
    _timeLabel.text = _timerSetting;
}

-(void)timerCall:timer
{
    [self timerSet];
    _timeLabel.text = _timerSetting;
}

-(void)timerSet
{
    NSDate *now = [NSDate date];
    _timerSetting = [_timeFormat stringFromDate:now];
}

@end
