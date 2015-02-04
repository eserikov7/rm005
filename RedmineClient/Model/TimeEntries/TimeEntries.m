//
//  TimeEntries.m
//  RedmineClient
//
//  Created by Евгений Сериков on 04.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "TimeEntries.h"
#import "NetworkingManager.h"
#import "ServersModel.h"

@implementation TimeEntries
{
    NSArray* _timeEntries;
}

- (NSArray*)timeEntries
{
    return _timeEntries;
}

- (void)loadSpentTimeSuccess:(void (^)())success
                     failure:(void (^)( NSError *error))failure
{
    [[ServersModel activeServer].url URLByAppendingPathComponent:<#(NSString *)#>]
}
@end
