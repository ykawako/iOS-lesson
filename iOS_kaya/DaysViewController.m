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
@property (strong, nonatomic) NSDate *today;
@end

@implementation DaysViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];
    NSString *yearAndMonth = [dateFormatter stringFromDate:self.today];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    self.days = [NSMutableArray array];
    NSArray *weeks = @[@"日", @"月", @"火", @"水", @"木", @"金", @"土"];
    NSDateComponents *componentDate = [calendar components:NSYearCalendarUnit  |
                                                           NSMonthCalendarUnit |
                                                           NSDayCalendarUnit
                                                  fromDate:self.today];
    NSInteger daysOfThisMonth = [calendar rangeOfUnit:NSDayCalendarUnit
                                               inUnit:NSMonthCalendarUnit
                                              forDate:self.today].length;
    for(int dayNumber = 1; dayNumber <= daysOfThisMonth; dayNumber++){
        [componentDate setDay:dayNumber];
        NSDate *date = [calendar dateFromComponents:componentDate];
        NSDateComponents *weekNumber = [calendar components:NSWeekdayCalendarUnit
                                                   fromDate:date];
        NSString *day = [NSString stringWithFormat:@"%@%02d(%@)", yearAndMonth, dayNumber, weeks[[weekNumber weekday]-1]];
        [self.days addObject:day];
    }
    [self.days addObject:@""];
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
    return [self.days count];
}

- (UITableViewCell *)tableView:tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"CellList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor whiteColor];
    
    UIColor *redColor = [UIColor colorWithRed:1.0 green:0.2 blue:0.2 alpha:1.0];
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBackgroundView.backgroundColor = redColor;
    cell.selectedBackgroundView = selectedBackgroundView;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.days objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self.today];
    UIView *todayBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    todayBackgroundView.backgroundColor = [UIColor greenColor];
    if (comps.day-1 == indexPath.row) {
        UIColor *greenColor = [UIColor colorWithRed:0.0 green:0.8 blue:0.6 alpha:1.0];
        [cell setBackgroundColor:greenColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
}

@end