//
//  UIActionCell.m
//  RedmineClient
//
//  Created by Евгений Сериков on 09.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "UIActionCell.h"
#import <BlocksKit+UIKit.h>

@implementation UIActionCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setActionInfo:(ActionInfo *)actionInfo
{
    _actionInfo = actionInfo;
    
    self.name.text = actionInfo.name;
    [self.name setBk_shouldEndEditingBlock:^BOOL(UITextField *textField) {
        actionInfo.name = textField.text;
        return YES;
    }];
    
    self.name.text = actionInfo.name;
    [self.name setBk_shouldEndEditingBlock:^BOOL(UITextField *textField) {
        actionInfo.name = textField.text;
        return YES;
    }];

    self.defaultDescription.text = actionInfo.defaultDescription;
    self.defaultDescription.delegate = self;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    self.actionInfo.defaultDescription = textView.text;
    return YES;
}
@end
