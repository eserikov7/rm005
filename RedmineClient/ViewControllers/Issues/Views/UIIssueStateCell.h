//
//  UIIssueStateCell.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 16.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionInfo.h"

@interface UIIssueStateCell : UITableViewCell<UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic)IBOutlet UITextField* name;

@property(nonatomic)IBOutlet UILabel* assignedToTtl;
@property(nonatomic)IBOutlet UITextField* assignedTo;

@property(nonatomic)IBOutlet UILabel* statusTtl;
@property(nonatomic)IBOutlet UITextField* status;

@property(nonatomic)IBOutlet UILabel* doneRatioTtl;
@property(nonatomic)IBOutlet UITextField* doneRatio;

@property(nonatomic)IBOutlet UILabel* descriptionTtl;
@property(nonatomic)IBOutlet UITextView* defaultDescription;

@property(nonatomic)IBOutlet UILabel* timeTtl;
@property(nonatomic)IBOutlet UITextField* time;
@property(nonatomic)IBOutlet UIStepper* timeStepper;

@property(nonatomic)IBOutlet UILabel* timeEntryActivityTtl;
@property(nonatomic)IBOutlet UITextField* timeEntryActivity;

@property(nonatomic)ActionInfo* actionInfo;

@end
