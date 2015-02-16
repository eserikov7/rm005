//
//  UIIssueUpdateStateVC.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 16.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "UIIssueUpdateStateVC.h"
#import "UIIssueStateCell.h"

@interface UIIssueUpdateStateVC ()

@end

@implementation UIIssueUpdateStateVC
{
    IBOutlet UITableView*table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)closeAction:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIIssueStateCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UIIssueStateCell"];
    cell.actionInfo = self.actionInfo;
    return cell;
}

@end
