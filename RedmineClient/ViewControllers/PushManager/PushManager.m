//
//  PushManager.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 07.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "PushManager.h"
#import <UIKit/UIKit.h>
#import "ServersModel.h"

@implementation PushManager
{
    NSMutableDictionary* pushNotifications;
}

+ (instancetype)instance
{
    static PushManager *inst = nil;
    if(inst == nil)
        inst = [[self alloc] init];
    return inst;
}

- (instancetype)init
{
    self = [super init];
    pushNotifications = [[ServersModel instance].storage objectForKey:@"pushNotifications"];
    if(pushNotifications == nil)
        pushNotifications = [NSMutableDictionary dictionary];
    return self;
}

- (void)addPushAtTime:(NSDate*)date forUser:(NSString*)login
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

    if([pushNotifications objectForKey:login] == nil)
    {
        [pushNotifications removeObjectForKey:login];
    }
    
    [pushNotifications setObject:date forKey:login];
    
    [[ServersModel instance].storage setObject:pushNotifications forKey:@"pushNotifications"];
    
    for (NSString*key in [pushNotifications allKeys])
    {
        
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];

        localNotification.fireDate = [pushNotifications objectForKey:key];
        localNotification.alertBody = NSLocalizedString(@"push_notification_message", @"");
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.repeatInterval = kCFCalendarUnitMinute;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
    

}

@end

