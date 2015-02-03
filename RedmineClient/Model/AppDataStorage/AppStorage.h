//
//  AppStorage.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 03.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppStorage : NSObject

- (id)objectForKey:(NSString*)key;
- (void)setObject:(id)obj forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;
- (void)clean;

@end
