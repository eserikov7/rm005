//
//  TimeEntries.h
//  RedmineClient
//
//  Created by Евгений Сериков on 04.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeEntries : NSObject

@property(nonatomic,readonly) float todaySpentTime;
@property(nonatomic,readonly) NSArray* items;

- (void)loadSpentTimeSuccess:(void (^)())success
                     failure:(void (^)( NSError *error))failure;
@end
