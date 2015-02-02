//
//  ServerInfo.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 03.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerInfo : NSObject

@property(nonatomic,readonly) NSURL *url;

@property(nonatomic,readonly) NSString *login;
@property(nonatomic,readonly) NSString *serverName;
@property(nonatomic,readonly) NSString *serverDomain;


- (instancetype)initWithServerName:(NSString*)serverName
                      serverDomain:(NSString*)serverDomain;

- (void)loginWithUser:(NSString*)login
             password:(NSString*)password
              success:(void (^)())success
              failure:(void (^)( NSError *error))failure;
@end
