//
//  TimeEntry.m
//  RedmineClient
//
//  Created by Евгений Сериков on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "TimeEntry.h"

@implementation TimeEntry

- (void)parce:(NSDictionary*)dict
{
   self.Id = [dict objectForKey:@"id"];
   self.hours = [[dict objectForKey:@"hours"] floatValue];
   self.comments = [dict objectForKey:@"comments"];

    self.project = [[ProjectModel alloc] init];
    [self.project parce:[dict objectForKey:@"project"]];
    
    self.issue = [[IssueModel alloc] init];
    [self.issue parce:[dict objectForKey:@"issue"]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
   self.spent_on = [dateFormatter dateFromString:[dict objectForKey:@"spent_on"]];
}


@end
