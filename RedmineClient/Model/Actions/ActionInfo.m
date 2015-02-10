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


- (id)initWithCoder:(NSCoder *)decoder
{
    
    self = [super init];
    if (self) {
        _Id = [decoder decodeIntegerForKey:@"_Id"];
        _name = [decoder decodeObjectForKey:@"_name"];
        
        _assigned_to = [decoder decodeObjectForKey:@"_assigned_to"];
        _status = [decoder decodeObjectForKey:@"_status"];
        _projectModel = [decoder decodeObjectForKey:@"_projectModel"];
        _done_ratio = [decoder decodeIntegerForKey:@"_done_ratio"];
        _defaultDescription = [decoder decodeObjectForKey:@"_defaultDescription"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:_Id forKey:@"_Id"];
    [encoder encodeObject:_name forKey:@"_name"];
    
    [encoder encodeObject:_assigned_to forKey:@"_assigned_to"];
    [encoder encodeObject:_status forKey:@"_status"];
    [encoder encodeObject:_projectModel forKey:@"_projectModel"];
    [encoder encodeInteger:_done_ratio forKey:@"_done_ratio"];
    [encoder encodeObject:_defaultDescription forKey:@"_defaultDescription"];
}

@end
