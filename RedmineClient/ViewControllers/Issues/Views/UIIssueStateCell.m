//
//  UIIssueStateCell.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 16.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "UIIssueStateCell.h"
#import <BlocksKit+UIKit.h>
#import "ServersModel.h"

enum{
    ID_STATUS = 1,
    ID_DONE_RATION,
    ID_ASSIGN_TO
    
};

@implementation UIIssueStateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setActionInfo:(ActionInfo *)actionInfo
{
    _actionInfo = actionInfo;

    
    UIPickerView * statusPicker = [[UIPickerView alloc] init];
    statusPicker.tag = ID_STATUS;
    statusPicker.delegate = self;
    statusPicker.dataSource = self;
    self.status.inputView = statusPicker;
    
    if(actionInfo.status)
    {
        self.status.text = actionInfo.status.name;
    }
    else
    {
        self.status.text = @"No change";
    }
    
    UIPickerView * doneRatioPicker = [[UIPickerView alloc] init];
    doneRatioPicker.tag = ID_DONE_RATION;
    doneRatioPicker.delegate = self;
    doneRatioPicker.dataSource = self;
    self.doneRatio.inputView = doneRatioPicker;
    
    if(actionInfo.done_ratio>=0)
    {
        self.doneRatio.text = [NSString stringWithFormat:@"%ld", (long)actionInfo.done_ratio];
    }
    else
    {
        self.doneRatio.text = @"No change";
    }
    
    UIPickerView * assignedToPicker = [[UIPickerView alloc] init];
    assignedToPicker.tag = ID_ASSIGN_TO;
    assignedToPicker.delegate = self;
    assignedToPicker.dataSource = self;
    self.assignedTo.inputView = assignedToPicker;
    
    if(actionInfo.assigned_to)
    {
        self.assignedTo.text = actionInfo.assigned_to.name;
    }
    else
    {
        self.assignedTo.text = @"No change";
    }
    
    
    self.defaultDescription.text = actionInfo.defaultDescription;
    self.defaultDescription.delegate = self;

    
    
    self.time.text =  [NSString stringWithFormat:@"%.2f",actionInfo.time];
    self.timeStepper.value = actionInfo.time;
    
    [self.timeStepper bk_addEventHandler:^(UIStepper* sender) {
        actionInfo.time = sender.value;
        self.time.text =  [NSString stringWithFormat:@"%.2f",actionInfo.time];
    } forControlEvents:UIControlEventValueChanged];
    
    __weak UIIssueStateCell*__self = self;
    [self.time setBk_shouldEndEditingBlock:^BOOL(UITextField *tf) {
        actionInfo.time = [[tf.text stringByReplacingOccurrencesOfString:@"," withString:@"."] floatValue];
        tf.text =  [NSString stringWithFormat:@"%.2f",actionInfo.time];
        __self.timeStepper.value = actionInfo.time;
        return YES;
    }];
    
    self.defaultDescription.text = actionInfo.defaultDescription;
    self.defaultDescription.delegate = self;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case ID_STATUS:
            return [ServersModel activeServer].redmineInfo.statuses.count+1;
            break;
        case ID_DONE_RATION:
            return 12;
            break;
        case ID_ASSIGN_TO:
        {
            if(self.actionInfo.projectModel)
            {
                if(self.actionInfo.projectModel.users.count>0)
                    return self.actionInfo.projectModel.users.count;
                else
                {
                    [self.actionInfo.projectModel loadUsersSuccess:^{
                        [pickerView reloadAllComponents];
                    } failure:^(NSError *error) {
                        
                    }];
                    return 0;
                }
            }
            else
            {
                return [ServersModel activeServer].redmineInfo.users.count;
            }
            
        }
            break;
        default:
            break;
    }
    
    return 0;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case ID_STATUS:
        {
            if(row == 0)
                return @"No change";
            return ((StatusModel*)[[ServersModel activeServer].redmineInfo.statuses objectAtIndex:row-1]).name;
        }
            break;
            
        case ID_DONE_RATION:
        {
            if(row == 0)
                return @"No change";
            return [NSString stringWithFormat:@"%ld", (long)(row-1)*10];
        }
            break;
        case ID_ASSIGN_TO:
        {
            if(row == 0)
                return @"No change";
            if(self.actionInfo.projectModel)
            {
                return ((UserModel*)[self.actionInfo.projectModel.users objectAtIndex:row-1]).name;
            }
            else
            {
                return ((UserModel*)[[ServersModel activeServer].redmineInfo.users objectAtIndex:row-1]).name;
            }
            
        }
            break;
        default:
            break;
    }
    
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case ID_STATUS:
        {
            if(row == 0)
            {
                self.status.text = @"No change";
                self.actionInfo.status = nil;
            }
            else
            {
                self.actionInfo.status = (StatusModel*)[[ServersModel activeServer].redmineInfo.statuses objectAtIndex:row-1];
                self.status.text = self.actionInfo.status.name;
            }
        }
            break;
        case ID_DONE_RATION:
        {
            if(row == 0)
            {
                self.doneRatio.text = @"No change";
                self.actionInfo.done_ratio = -1;
            }
            else
            {
                self.actionInfo.done_ratio = (long)(row-1)*10;
                self.doneRatio.text = [NSString stringWithFormat:@"%ld", (long)(row-1)*10];
            }
        }
            break;
            
        case ID_ASSIGN_TO:
        {
            if(row == 0)
            {
                self.assignedTo.text = @"No change";
                self.actionInfo.assigned_to = nil;
            }
            else
            {
                if(self.actionInfo.projectModel)
                {
                    self.actionInfo.assigned_to = ((UserModel*)[self.actionInfo.projectModel.users objectAtIndex:row-1]);
                }
                else
                {
                    self.actionInfo.assigned_to = ((UserModel*)[[ServersModel activeServer].redmineInfo.users objectAtIndex:row-1]);
                }
                self.assignedTo.text = self.actionInfo.assigned_to.name;
            }
        }
            break;
            
        default:
            break;
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    self.actionInfo.defaultDescription = textView.text;
    return YES;
}

@end
