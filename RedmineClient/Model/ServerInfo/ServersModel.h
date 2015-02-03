//
//  ServersModel.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 03.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerInfo.h"

@interface ServersModel : NSObject

+ (instancetype)instance;


+ (ServerInfo*)activeServer;

@property(nonatomic,readonly)NSArray* serversList;
@property(nonatomic,readonly)ServerInfo* activeServerInfo;

- (void)loginWithUser:(NSString*)login
             password:(NSString*)password
              success:(void (^)())success
              failure:(void (^)( NSError *error))failure;

@end
