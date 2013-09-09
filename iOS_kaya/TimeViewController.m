//
//  TimeViewController.m
//  iOS_kaya
//
//  Created by 河原 on 2013/09/03.
//  Copyright (c) 2013年 河原. All rights reserved.
//

#import "TimeViewController.h"

@interface TimeViewController ()

@end

@implementation TimeViewController
@synthesize timeLabel;
@synthesize timer;
@synthesize time;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //NSTimerの設定。１秒毎読み込みにいく
    timer =
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(timerCall:)
                                   userInfo:nil
                                    repeats:YES
     ];

    [self timerSet];
    timeLabel.text = time;
}

-(void)timerCall:timer
{   //１秒毎に読み込まれるメソッド
    [self timerSet];
    timeLabel.text = time;
}

-(void)timerSet{
    //表示する日付、時間の設定。JSTとは日本標準時
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];
    time = [dateFormatter stringFromDate:now];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
