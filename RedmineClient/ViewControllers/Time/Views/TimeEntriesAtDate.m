//
//  TimeEntriesAtDate.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 08.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "TimeEntriesAtDate.h"
#import "TimeEntry.h"

@implementation TimeEntriesAtDate

- (instancetype)init
{
    self = [super init];
    
    self.items = [NSMutableArray array];
    
    return self;
}

@end
