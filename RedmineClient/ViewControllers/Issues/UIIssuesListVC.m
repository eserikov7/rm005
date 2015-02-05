//
//  UIIssuesListVC.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 06.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "UIIssuesListVC.h"
#import "IssueModel.h"

@interface UIIssuesListVC ()

@end

@implementation UIIssuesListVC

{
    IBOutlet UITableView* table;
    
    UITableViewCell* initCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    initCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"projectCell"];
    
    [self.project loadIssuesSuccess:^{
        [table reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.project.issues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"projectCell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"projectCell"];
    }
    
    IssueModel* issue = [self.project.issues objectAtIndex:indexPath.row];
    
    cell.textLabel.text = issue.subject;
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.text = issue.issueDescription;
    cell.detailTextLabel.numberOfLines = 0;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 60;
    
    IssueModel* issue = [self.project.issues objectAtIndex:indexPath.row];

    
    CGRect r = [issue.subject boundingRectWithSize:CGSizeMake(self.view.bounds.size.width-30, CGFLOAT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName: initCell.textLabel.font}
                                           context:nil];

    height+=r.size.height;
    
    r = [issue.issueDescription boundingRectWithSize:CGSizeMake(self.view.bounds.size.width-30, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName: initCell.detailTextLabel.font}
                                             context:nil];
    
    height+=r.size.height;
    
    return height;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
