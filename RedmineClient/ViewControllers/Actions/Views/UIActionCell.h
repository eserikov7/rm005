//
//  UIActionCell.h
//  RedmineClient
//
//  Created by Евгений Сериков on 09.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionInfo.h"

@interface UIActionCell : UITableViewCell<UITextViewDelegate>

@property(nonatomic)IBOutlet UILabel* nameTtl;
@property(nonatomic)IBOutlet UITextField* name;

@property(nonatomic)IBOutlet UILabel* assignedToTtl;
@property(nonatomic)IBOutlet UITextField* assignedTo;

@property(nonatomic)IBOutlet UILabel* statusTtl;
@property(nonatomic)IBOutlet UITextField* status;

@property(nonatomic)IBOutlet UILabel* doneRatioTtl;
@property(nonatomic)IBOutlet UITextField* doneRatio;

@property(nonatomic)IBOutlet UILabel* projectTtl;
@property(nonatomic)IBOutlet UITextField* project;

@property(nonatomic)IBOutlet UILabel* descriptionTtl;
@property(nonatomic)IBOutlet UITextView* defaultDescription;

@property(nonatomic)ActionInfo* actionInfo;

@end
