//
//  UserModel.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 08.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (BOOL)isEqual:(id)object
{
    if([object isKindOfClass:[self class]])
        return self.Id == ((UserModel*)object).Id;
    return NO;
}

- (void)parce:(NSDictionary*)dict
{
    self.Id = [[dict objectForKey:@"id"] integerValue];
    self.name = [dict objectForKey:@"name"];
}

@end
