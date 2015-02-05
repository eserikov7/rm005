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

@interface UITimeEntriesInfoVC ()

@end

@implementation UITimeEntriesInfoVC
{
    IBOutlet UITableView* table;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    self.navigationItem.title = NSLocalizedString(@"time_ttl", @"");
    
    [[ServersModel activeServer].timeEntries loadSpentTimeSuccess:^{
        [table reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 120.0;
    return 50.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ServersModel activeServer].timeEntries.items.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(indexPath.row == 0)
    {
        UIFullTimeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UIFullTimeCell"];
        
        int hours = (int)([ServersModel activeServer].timeEntries.todaySpentTime);
        int mins = ([ServersModel activeServer].timeEntries.todaySpentTime-hours)*60.0;
        cell.timeValue.text = [NSString stringWithFormat:@"%d ч. %d мин.", hours, mins];
        
        return cell;
    }
    else if(indexPath.row>0)
    {
        UITimeEnteryCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITimeEnteryCell"];
        cell.timeEntry = [[ServersModel activeServer].timeEntries.items objectAtIndex:indexPath.row-1];
        return cell;
    }
    return nil;
}

@end
