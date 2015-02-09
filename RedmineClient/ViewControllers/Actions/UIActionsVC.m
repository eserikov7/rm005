//
//  UIActionsVC.m
//  RedmineClient
//
//  Created by Евгений Сериков on 09.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "UIActionsVC.h"
#import "ServersModel.h"
#import "UIActionCell.h"

@interface UIActionsVC ()

@end

@implementation UIActionsVC
{
    IBOutlet UITableView*table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)addAction:(id)sender
{
    ActionInfo* action = [[ActionInfo alloc] init];
    [[ServersModel activeServer].actionsModel addActionInfo:action];
    
    action.name = [NSString stringWithFormat:@"Action %ld", action.Id];
    [table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ServersModel activeServer].actionsModel.actions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIActionCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UIActionCell"];
    
    cell.actionInfo = [[ServersModel activeServer].actionsModel.actions objectAtIndex:indexPath.row];
    
    return cell;
}

@end
