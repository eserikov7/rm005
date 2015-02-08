//
//  TimeEntriesAtDate.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 08.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TimeEntriesAtDate : NSObject

@property(nonatomic)NSDate* date;
@property(nonatomic)CGFloat todaySpentTime;
@property(nonatomic)NSMutableArray* items;


@end
