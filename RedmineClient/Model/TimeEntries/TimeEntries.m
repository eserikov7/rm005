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
    
    [manager GET:[[url absoluteString] stringByAppendingString:@"?f[]=user_id&op[user_id]==&v[user_id][]=me&limit=90"]
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
    if ([dict objectForKey:@"time_entries"]) {
 

        NSDateComponents* components = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                                       fromDate:[NSDate date]];
        
        NSDate *currentDate =[[NSCalendar currentCalendar] dateFromComponents:components];

        _todaySpentTime = 0;
        NSMutableArray* items = [NSMutableArray array];
        for(NSDictionary*itemDict in [dict objectForKey:@"time_entries"])
        {
            TimeEntry * entry = [[TimeEntry alloc] init];
            [entry parce:itemDict];
            
            NSDateComponents* components = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                                           fromDate:entry.spent_on];

            if([currentDate isEqualToDate:[[NSCalendar currentCalendar] dateFromComponents:components]])
            {
                _todaySpentTime += entry.hours;
                [items addObject:entry];
            }
        }
        _timeEntries = items;
    }

    
}
@end
