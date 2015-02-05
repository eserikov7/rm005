//
//  UIIssuesListVC.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 06.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectModel.h"

@interface UIIssuesListVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic)ProjectModel*project;

@end
