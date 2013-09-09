//
//  CalViewController.m
//  iOS_kaya
//
//  Created by 河原 on 2013/09/04.
//  Copyright (c) 2013年 河原. All rights reserved.
//

#import "CalViewController.h"

@interface CalViewController ()

@end

@implementation CalViewController
@synthesize nengetsu;
@synthesize youbi, year, month;
@synthesize youbiNum;
@synthesize comp;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //曜日の配列
    youbi = [[NSArray alloc] initWithObjects:@"日", @"月", @"火",@"水", @"木", @"金",@"土", nil];
    //配列データを入れていく
    days = [NSMutableArray array];
    //今日の日時取得
    NSDate *toDay = [NSDate date];
    //フォーマット：2013/09　　日本標準時時刻　ストリング型の変数に代入
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];
    nengetsu = [dateFormatter stringFromDate:toDay];
    //カレンダーを使う
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //今月の日数を取得
    NSInteger daysOfThisMonth = [ calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:toDay ].length;
    
    //年月日を別々に取得したい。今日のデータで作成
    comp = [[NSDateComponents alloc] init];
    comp = [calendar components:NSYearCalendarUnit |
            NSMonthCalendarUnit |
            NSDayCalendarUnit
                       fromDate:toDay];
    
    year = comp.year;
    month = comp.month;
    
    
    for(int i = 1; i <= daysOfThisMonth; i++){
        //日付を更新。イント型iに合わせて日付を入れていく。
        [comp setYear:year];
        [comp setMonth:month];
        [comp setDay:i];
        
        //曜日取得の為に生成
        NSDate *date = [calendar dateFromComponents:comp];
        comp = [calendar components:NSWeekdayCalendarUnit
                           fromDate:date];
        //weekday➡１〜７で曜日を出力。配列対応のため-１で0〜6で変数に突っ込む。
        youbiNum = [comp weekday]-1;
        
        //日付のフォーマット➡01となるように変更してやる
        NSString *hiduke = [NSString stringWithFormat:@"%02d", i];
        //文字をつなげる。文字と文字を結合したもの。　曜日は配列の中身をweekday-1で取得。
        NSString *day = [NSString stringWithFormat:@"%@%@(%@)",nengetsu,hiduke,youbi[youbiNum]];
        //上で結合した文字列を配列に突っ込む。
        [days addObject:day];
    }
}

- (void)configCellForSelected:(UITableViewCell *)cell
{
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    [cell.selectedBackgroundView setBackgroundColor:[UIColor redColor]];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


//セルのセクション数。１。
- (NSInteger)numberOfSectionsInTableView:tableView
{
    return 1;
}

//セルの列数を指定。daysの数を返す。９月は30。
- (NSInteger)tableView:tableView numberOfRowsInSection:(NSInteger)section
{
    return [days count];
}



- (UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor whiteColor];
    
    //新しいViewを置いて、選択されたときだけ背景変更。
    UIColor *redcolor = [UIColor colorWithRed:1.0 green:0.2 blue:0.2 alpha:1.0];
    UIView *selected_bg_view = [[UIView alloc] initWithFrame:cell.bounds];
    selected_bg_view.backgroundColor = redcolor;
    cell.selectedBackgroundView = selected_bg_view;
    
    //セルに配列の番号順にいれる
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[days objectAtIndex:indexPath.row]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = NSDayCalendarUnit;
    NSDateComponents *comps = [calendar components:flags fromDate:now];
    NSInteger day = comps.day;
    
    NSString* kyo = [ NSString stringWithFormat : @"%d", day-1];
    
    UIView *today_bg_view = [[UIView alloc] initWithFrame:cell.bounds];
    today_bg_view.backgroundColor = [UIColor greenColor];
    
    // 取り出した値に応じてセルの背景色を指定。
    if ( [kyo isEqualToString:[NSString stringWithFormat:@"%d", indexPath.row]] ) {
        UIColor *greencolor = [UIColor colorWithRed:0.0 green:0.8 blue:0.6 alpha:1.0];
        [cell setBackgroundColor:greencolor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
