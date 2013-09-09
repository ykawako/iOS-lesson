//
//  TimeViewController.h
//  iOS_kaya
//
//  Created by 河原 on 2013/09/03.
//  Copyright (c) 2013年 河原. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeViewController : UIViewController
@property (nonatomic) NSTimer *timer;                       //1秒おきに読み込む用
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;    //時間を表示する用
@property (weak, nonatomic) NSString *time;                 //ラベルに出力する用

@end
