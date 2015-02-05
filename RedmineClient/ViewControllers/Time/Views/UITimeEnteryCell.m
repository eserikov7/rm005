//
//  UITimeEnteryCell.m
//  RedmineClient
//
//  Created by Евгений Сериков on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "UITimeEnteryCell.h"

@implementation UITimeEnteryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTimeEntry:(TimeEntry *)timeEntry
{
    _timeEntry = timeEntry;
    
    self.timeEnteryTitle.text = [NSString stringWithFormat:@"%@ (#%@)", timeEntry.project.name, timeEntry.issue.Id];
    self.timeValue.text = [NSString stringWithFormat:@"%.2f ч.",timeEntry.hours];
}

@end
