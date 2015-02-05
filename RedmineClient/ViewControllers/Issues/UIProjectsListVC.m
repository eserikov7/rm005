//
//  UIProjectsListVC.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 06.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "UIProjectsListVC.h"
#import "ServersModel.h"
#import "UIIssuesListVC.h"

@interface UIProjectsListVC ()

@end

@implementation UIProjectsListVC
{
    IBOutlet UITableView* table;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[ServersModel activeServer].projectsManager loadProjectsSuccess:^{
        [table reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ServersModel activeServer].projectsManager.projects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"projectCell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"projectCell"];
    }
    
    ProjectModel* proj = [[ServersModel activeServer].projectsManager.projects objectAtIndex:indexPath.row];
    
    cell.textLabel.text = proj.name;
    cell.detailTextLabel.text = proj.identifier;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIIssuesListVC*vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UIIssuesListVC"];
    vc.project = [[ServersModel activeServer].projectsManager.projects objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
