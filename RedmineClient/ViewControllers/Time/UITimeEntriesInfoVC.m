//
//  UITimeEntriesInfoVC.m
//  RedmineClient
//
//  Created by Евгений Сериков on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "UITimeEntriesInfoVC.h"
#import "ServersModel.h"
#import "UIFullTimeCell.h"
#import "UITimeEnteryCell.h"
#import "TimeEntriesAtDate.h"

@interface UITimeEntriesInfoVC ()

@end

@implementation UITimeEntriesInfoVC
{
    IBOutlet UITableView* table;
    
    NSMutableArray* items;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    self.navigationItem.title = NSLocalizedString(@"time_ttl", @"");
    
    [[ServersModel activeServer].timeEntries loadSpentTimeSuccess:^{
        [table reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)prepareItems
{
    items = [NSMutableArray array];

    NSDateComponents* currentDateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                                   fromDate:[NSDate date]];
    
    for(int i = 0; i<7;i++)
    {
        TimeEntriesAtDate* timeEntriesAtDate = [[TimeEntriesAtDate alloc] init];
        timeEntriesAtDate.date = [[NSCalendar currentCalendar] dateFromComponents:currentDateComponents];
        [items addObject:timeEntriesAtDate];
        currentDateComponents.day--;
    }
 
    for (TimeEntry *timeEntry in [ServersModel activeServer].timeEntries.items) {
        NSDateComponents* components = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                                       fromDate:timeEntry.spent_on];
        
        for(TimeEntriesAtDate* timeEntriesAtDate in items)
        {
            if([timeEntriesAtDate.date isEqualToDate:[[NSCalendar currentCalendar] dateFromComponents:components]])
            {
                timeEntriesAtDate.todaySpentTime += timeEntry.hours;
                [timeEntriesAtDate.items addObject:timeEntry];
                break;
            }
        }
        

    }

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [self prepareItems];
    
    return items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (( TimeEntriesAtDate*)[items objectAtIndex:section]).items.count+1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TimeEntriesAtDate*timeEntriesAtDate = [items objectAtIndex:section];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate * now = [NSDate date];
    NSDateComponents *components = [calendar components:
                                    NSYearCalendarUnit|
                                    NSMonthCalendarUnit|
                                    NSWeekCalendarUnit|
                                    NSDayCalendarUnit
                                               fromDate:timeEntriesAtDate.date
                                                 toDate:now
                                                options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    
    
    switch (components.day) {
        case 0:
            return [NSString stringWithFormat:@"%@ (%@)",NSLocalizedString(@"time_today", @""),[dateFormatter stringFromDate:timeEntriesAtDate.date]];
            break;
        case 1:
            return [NSString stringWithFormat:@"%@ (%@)",NSLocalizedString(@"time_yesterday", @""),[dateFormatter stringFromDate:timeEntriesAtDate.date]];
            break;
        case 2:
        case 3:
        case 4:
            return [NSString stringWithFormat:@"%d %@ (%@)",components.day,NSLocalizedString(@"time_days_ago_34", @""),[dateFormatter stringFromDate:timeEntriesAtDate.date]];
            
            break;
        default:
            return [NSString stringWithFormat:@"%d %@ (%@)",components.day,NSLocalizedString(@"time_days_ago_56", @""),[dateFormatter stringFromDate:timeEntriesAtDate.date]];
            break;
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 90.0;
    
    return 50.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(indexPath.row == 0)
    {
        TimeEntriesAtDate*timeEntriesAtDate = [items objectAtIndex:indexPath.section];
        

        NSDateComponents *components = [[NSCalendar currentCalendar] components: NSWeekdayCalendarUnit
                                                   fromDate:timeEntriesAtDate.date];

        UIFullTimeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UIFullTimeCell"];
        
        if(components.weekday == 1 || components.weekday == 7)
        {
            cell.contentView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        }
        else
        {
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        int hours = (int)(timeEntriesAtDate.todaySpentTime);
        int mins = (timeEntriesAtDate.todaySpentTime-hours)*60.0;
        cell.timeValue.text = [NSString stringWithFormat:@"%d ч. %d мин.", hours, mins];
        
        return cell;
    }
    else if(indexPath.row>0)
    {
        TimeEntriesAtDate*timeEntriesAtDate = [items objectAtIndex:indexPath.section];
        UITimeEnteryCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITimeEnteryCell"];
        cell.timeEntry = [timeEntriesAtDate.items objectAtIndex:indexPath.row-1];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
