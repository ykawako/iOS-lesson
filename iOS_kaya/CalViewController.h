//
//  CalViewController.h
//  iOS_kaya
//
//  Created by 河原 on 2013/09/04.
//  Copyright (c) 2013年 河原. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalViewController : UITableViewController
{
    NSMutableArray *days;
}
@property (weak, nonatomic) NSString *nengetsu; // yyyy/MM/
@property (nonatomic) NSArray *youbi;           //日〜土までの曜日配列
@property (nonatomic) int youbiNum, year, month;             //０(日)〜６(土)までの数字を返す
@property (nonatomic) NSDateComponents *comp;
@end
