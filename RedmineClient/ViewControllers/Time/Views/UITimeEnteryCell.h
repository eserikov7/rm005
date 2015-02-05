//
//  UITimeEnteryCell.h
//  RedmineClient
//
//  Created by Евгений Сериков on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeEntry.h"

@interface UITimeEnteryCell : UITableViewCell

@property(nonatomic)IBOutlet UILabel* timeEnteryTitle;
@property(nonatomic)IBOutlet UILabel* timeValue;

@property(nonatomic)TimeEntry* timeEntry;

@end
