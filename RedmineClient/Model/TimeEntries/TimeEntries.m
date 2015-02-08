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
#import "Constants.h"
#import "TimeEntry.h"


@implementation TimeEntries
{
    NSArray* _timeEntries;
}

- (NSArray*)items
{
    return _timeEntries;
}

- (void)loadSpentTimeSuccess:(void (^)())success
                     failure:(void (^)( NSError *error))failure
{
    NSURL* url = [[ServersModel activeServer].url URLByAppendingPathComponent:kTimeEntries];
    

    NetworkingManager* manager = [NetworkingManager manager];
    
    NSDateComponents *currComps = [[NSCalendar currentCalendar] components:kCFCalendarUnitYear| kCFCalendarUnitMonth|kCFCalendarUnitDay|kCFCalendarUnitHour|kCFCalendarUnitMinute
                                               fromDate:[NSDate date]];
    currComps.day -=8;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString* sUrl = [NSString stringWithFormat:@"%@?f[]=spent_on&op[spent_on]=>=&v[spent_on][]=%@&f[]=user_id&op[user_id]==&v[user_id][]=me&limit=100",
                      [url absoluteString],
                      [dateFormatter stringFromDate:[[NSCalendar currentCalendar] dateFromComponents:currComps]]];
    
    
    [manager GET:sUrl
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             if(responseObject)
             {
                 [self parce:responseObject];
                 
             }
             
             
             if(success)
                 success();
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if(failure)
                 failure(error);
         }];

}

- (void)parce:(NSDictionary*)dict
{
    if ([dict objectForKey:@"time_entries"])
    {
 
        NSMutableArray* items = [NSMutableArray array];
        for(NSDictionary*itemDict in [dict objectForKey:@"time_entries"])
        {
            TimeEntry * entry = [[TimeEntry alloc] init];
            [entry parce:itemDict];

            [items addObject:entry];
        }
        _timeEntries = items;
    }

    
}
@end
