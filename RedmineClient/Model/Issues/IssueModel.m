//
//  IssueModel.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "IssueModel.h"

@implementation IssueModel

- (BOOL)isEqual:(id)obj
{
    if([obj isKindOfClass:[self class]])
        return self.Id == ((IssueModel*)obj).Id;
    return NO;
}

- (void)parce:(NSDictionary*)dict
{
    self.Id = [[dict objectForKey:@"id"] integerValue];
    self.subject = [dict objectForKey:@"subject"];
    self.issueDescription = [dict objectForKey:@"description"];
    
    if([dict objectForKey:@"project"])
    {
        self.project = [[ProjectModel alloc] init];
        [self.project parce:[dict objectForKey:@"project"]];
    }
    
    if([dict objectForKey:@"tracker"])
    {
        self.tracker = [[TrackerModel alloc] init];
        [self.tracker parce:[dict objectForKey:@"tracker"]];
    }
    
    if([dict objectForKey:@"status"])
    {
        self.status = [[StatusModel alloc] init];
        [self.status parce:[dict objectForKey:@"status"]];
    }
    
    if([dict objectForKey:@"priority"])
    {
        self.priority = [[PriorityModel alloc] init];
        [self.priority parce:[dict objectForKey:@"priority"]];
    }
    
    if([dict objectForKey:@"author"])
    {
        self.author = [[UserModel alloc] init];
        [self.author parce:[dict objectForKey:@"author"]];
    }
    
    if([dict objectForKey:@"assigned_to"])
    {
        self.assigned_to = [[UserModel alloc] init];
        [self.assigned_to parce:[dict objectForKey:@"assigned_to"]];
    }
    
    self.done_ratio = [[dict objectForKey:@"done_ratio"] integerValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    self.created_on = [dateFormatter dateFromString:[dict objectForKey:@"created_on"]];
    self.updated_on = [dateFormatter dateFromString:[dict objectForKey:@"updated_on"]];

}

@end
