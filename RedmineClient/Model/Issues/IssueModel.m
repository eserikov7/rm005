//
//  IssueModel.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "IssueModel.h"

@implementation IssueModel

- (void)parce:(NSDictionary*)dict
{
    self.Id = [[dict objectForKey:@"id"] integerValue];
    self.subject = [dict objectForKey:@"subject"];
    self.issueDescription = [dict objectForKey:@"description"];
    
}

@end
