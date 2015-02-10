//
//  StatusModel.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 08.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "StatusModel.h"

@implementation StatusModel

- (BOOL)isEqual:(id)object
{
    if([object isKindOfClass:[self class]])
        return self.Id == ((StatusModel*)object).Id;
    return NO;
}

- (void)parce:(NSDictionary*)dict
{
    self.Id = [[dict objectForKey:@"id"] integerValue];
    self.name = [dict objectForKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    
    self = [super init];
    if (self) {
        _Id = [decoder decodeIntegerForKey:@"_Id"];
        _name = [decoder decodeObjectForKey:@"_name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:_Id forKey:@"_Id"];
    [encoder encodeObject:_name forKey:@"_name"];
}

@end
