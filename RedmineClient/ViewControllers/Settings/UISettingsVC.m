//
//  UISettingsVC.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "UISettingsVC.h"
#import "ServersModel.h"
#import<BlocksKit.h>
#import<BlocksKit+UIKit.h>

@implementation UISettingsVC
{
    IBOutlet UITableView*table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"settings_ttl", @"");
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 1)
        return 2;
    return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return NSLocalizedString(@"settings_account_info", @"");
            break;
        case 1:
            return NSLocalizedString(@"settings_push_notification", @"");
            break;
        case 2:
            return NSLocalizedString(@"settings_exit", @"");
            break;
        default:
            break;
    }
    
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"accountInfo"];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"accountInfo"];
            }
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [ServersModel activeServer].firstName, [ServersModel activeServer].lastName];
            
            return cell;
            
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
            
            
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"pushTime"];
                if(cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pushTime"];
                }
                
                cell.textLabel.text = NSLocalizedString(@"settings_push_notification", @"");
                
                UITextField* pushTime = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
                pushTime.textAlignment = NSTextAlignmentRight;
                
                UIDatePicker* picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
                [picker setDatePickerMode:UIDatePickerModeTime];
                pushTime.inputView = picker;
                
                [picker bk_addEventHandler:^(id sender) {
                    
                    [ServersModel activeServer].pushDate = picker.date;
                    
                    NSCalendar *calendar = [NSCalendar currentCalendar];
                    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:picker.date];
                    NSInteger hour = [components hour];
                    NSInteger minute = [components minute];
                    
                    pushTime.text = [NSString stringWithFormat:@"%d:%02d", hour, minute];
                    
                } forControlEvents:UIControlEventValueChanged];
                
                
                NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit)
                                                                               fromDate:[ServersModel activeServer].pushDate];
                NSInteger hour = [components hour];
                NSInteger minute = [components minute];
                
                picker.date = [ServersModel activeServer].pushDate;
                
                pushTime.text = [NSString stringWithFormat:@"%d:%02d", hour, minute];
                cell.accessoryView = pushTime;
                
                return cell;
            }
            else
            {
                UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"pushTimeAtHolidays"];
                if(cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pushTimeAtHolidays"];
                }
                
                cell.textLabel.text = NSLocalizedString(@"settings_push_at_holidays", @"");
                
                if([ServersModel activeServer].pushAtHolidays)
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                else
                    cell.accessoryType = UITableViewCellAccessoryNone;
                
                return cell;
            }
        }
            break;
        case 2:
        {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"exit"];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"exit"];
            }
            
            cell.textLabel.text = NSLocalizedString(@"settings_exit", @"");
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor redColor];
            
            return cell;
        }
            break;
        default:
            break;
    }
    
    return nil;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 1:
        {
            if(indexPath.row == 0)
            {
                UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
                if([cell.accessoryView isFirstResponder])
                    [cell.accessoryView resignFirstResponder];
                else
                    [cell.accessoryView becomeFirstResponder];
            }
            else
            {
                [ServersModel activeServer].pushAtHolidays = ![ServersModel activeServer].pushAtHolidays;
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
