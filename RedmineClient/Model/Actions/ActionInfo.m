//
//  ActionInfo.m
//  RedmineClient
//
//  Created by Евгений Сериков on 09.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "ActionInfo.h"

@implementation ActionInfo

- (BOOL)isEqual:(id)object
{
    if([object isKindOfClass:[self class]])
        return self.Id == ((ActionInfo*)object).Id;
    return NO;
}
@end
