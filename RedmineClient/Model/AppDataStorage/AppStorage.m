//
//  AppStorage.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 03.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "AppStorage.h"
#import "Constants.h"

@implementation AppStorage
{
    NSUserDefaults* stotege;
}

- (instancetype)init
{
    self = [super init];
    stotege = [[NSUserDefaults alloc] initWithSuiteName:kDomainName];
    return self;
}

- (id)objectForKey:(NSString*)key
{
    id obj = nil;
    NSData* data = [stotege objectForKey:key];
    if(data)
        obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return obj;
}

- (void)setObject:(id)obj forKey:(NSString *)key
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [stotege setObject:data forKey:key];
    [stotege synchronize];
}

- (void)removeObjectForKey:(NSString *)key
{
    [stotege removeObjectForKey:key];
    [stotege synchronize];
}

- (void)clean
{
    [stotege removePersistentDomainForName:kDomainName];
    [stotege synchronize];
}


@end
