//
//  DaysViewController.m
//  私の今を知る
//
//  Created by 河原 on 2013/09/10.
//  Copyright (c) 2013年 河原. All rights reserved.
//

#import "DaysViewController.h"

@interface DaysViewController ()
@property (nonatomic) NSMutableArray *days;
@property (weak, nonatomic) NSDate *today;
@end

@implementation DaysViewController

- (void)viewWillAppear:(BOOL)animated
{
    _today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];
    [dateFormatter setDateFormat:@"yyyy/MM/"];
    NSString *yearAndMonth = [dateFormatter stringFromDate:_today];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger daysOfThisMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:_today].length;

    _days = [NSMutableArray array];
    for(int dayNum = 1; dayNum <= daysOfThisMonth; dayNum++){
        NSDateComponents *comp = [calendar components:NSYearCalendarUnit |
                                 NSMonthCalendarUnit |
                                 NSDayCalendarUnit
                                 fromDate:_today];
        [comp setDay:dayNum];
        NSDate *date = [calendar dateFromComponents:comp];
        comp = [calendar components:NSWeekdayCalendarUnit
                            fromDate:date];
        NSArray *weeks = @[@"日", @"月", @"火", @"水", @"木", @"金", @"土"];
        NSString *day = [NSString stringWithFormat:@"%@%02d(%@)", yearAndMonth, dayNum, weeks[[comp weekday]-1]];
        [_days addObject:day];
    }
    NSLog(@"%@",_today);
}

- (void)configCellForSelected:(UITableViewCell *)cell
{
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    [cell.selectedBackgroundView setBackgroundColor:[UIColor redColor]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:tableView
{
    return 1;
}

- (NSInteger)tableView:tableView numberOfRowsInSection:(NSInteger)section
{
    return [_days count];
}



- (UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor whiteColor];
    
    UIColor *redcolor = [UIColor colorWithRed:1.0 green:0.2 blue:0.2 alpha:1.0];
    UIView *selectedBgView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBgView.backgroundColor = redcolor;
    cell.selectedBackgroundView = selectedBgView;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [_days objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = NSDayCalendarUnit;
    NSDateComponents *comps = [calendar components:flags fromDate:now];
    NSString* todayView = [NSString stringWithFormat : @"%d", comps.day-1];
    UIView *todayBgView = [[UIView alloc] initWithFrame:cell.bounds];
    todayBgView.backgroundColor = [UIColor greenColor];
    NSLog(@"%@ %@", _today, now);
    if ( [todayView isEqualToString:[NSString stringWithFormat:@"%d", indexPath.row]] ) {
        UIColor *greenColor = [UIColor colorWithRed:0.0 green:0.8 blue:0.6 alpha:1.0];
        [cell setBackgroundColor:greenColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
}

@end
