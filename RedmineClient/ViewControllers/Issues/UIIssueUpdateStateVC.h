//
//  UIIssueUpdateStateVC.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 16.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionInfo.h"

@interface UIIssueUpdateStateVC : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic)ActionInfo* actionInfo;
@end
