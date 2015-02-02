//
//  ServersModel.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 03.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "ServersModel.h"

@implementation ServersModel
{
    NSMutableArray *servers;
}

+ (instancetype)instance
{
    static ServersModel *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[self alloc] init];
    });
    return inst;
}

+ (ServerInfo*)activeServer
{
    return nil;
}

- (instancetype)init
{
    self = [super init];
    
    return self;
}

- (NSArray *)serversList
{
    return servers;
}

@end
