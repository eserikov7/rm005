//
//  PushManager.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 07.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushManager : NSObject

+ (instancetype)instance;

- (void)addPushAtTime:(NSDate*)date forUser:(NSString*)login;

@end
