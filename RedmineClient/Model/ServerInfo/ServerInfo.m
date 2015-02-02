//
//  ServerInfo.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 03.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "ServerInfo.h"
#import <AFNetworking.h>
#import "Constants.h"


@implementation ServerInfo

{
    NSString* accountLogin;
    NSString* accountPassword;
}
- (instancetype)initWithServerName:(NSString*)name
                      serverDomain:(NSString*)domain
{
    self = [super init];
    
    _serverName = name;
    _serverDomain = domain;
    
    return self;
}

- (void)loginWithUser:(NSString*)login
             password:(NSString*)password
              success:(void (^)())success
              failure:(void (^)( NSError *error))failure
{
 
    NSURL*url = [self serverURLBy:_serverDomain
                            login:login
                         password:password];
    
    url = [url URLByAppendingPathComponent:@"projects.json"];
    
    [[AFHTTPRequestOperationManager manager] GET:[url absoluteString]
                                      parameters:nil
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             
                                         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             
                                         }];
}

- (NSURL*)serverURLBy:(NSString*)domain
                 login:(NSString*)login
             password:(NSString*)password
{
    return [NSURL URLWithString:[NSString stringWithFormat:kServerUrl,login,password,domain]];
}
 
@end
