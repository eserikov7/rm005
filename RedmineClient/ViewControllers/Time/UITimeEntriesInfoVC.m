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

@interface UITimeEntriesInfoVC ()

@end

@implementation UITimeEntriesInfoVC
{
    IBOutlet UITableView* table;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [[ServersModel activeServer].timeEntries loadSpentTimeSuccess:^{
        [table reloadData];
    } failure:^(NSError *error) {
        
    }];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
  //  return [ServersModel activeServer].timeEntries.items.count+1;
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
    return nil;
}
@end
