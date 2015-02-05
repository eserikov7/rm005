//
//  ServersModel.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 03.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "ServersModel.h"
#import "NetworkingManager.h"
#import "Constants.h"
#import "AppStorage.h"

@implementation ServersModel
{
    NSMutableArray *servers;
    AppStorage *appStorage;
}

+ (instancetype)instance
{
    static ServersModel *inst = nil;
    if(inst == nil)
        inst = [[self alloc] init];
    return inst;
}

+ (ServerInfo*)activeServer
{
    return [ServersModel instance].activeServerInfo;
}

- (instancetype)init
{
    self = [super init];
    appStorage = [[AppStorage alloc] init];
    _activeServerInfo = [appStorage objectForKey:kActiveAccount];
    if(_activeServerInfo)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [_activeServerInfo updateAccountInfoSuccess:^{
                [appStorage setObject:_activeServerInfo forKey:kActiveAccount];
            } failure:^(NSError *error) {
                
            }];
        });
    }

    return self;
}

- (NSArray *)serversList
{
    return servers;
}


- (void)loginWithUser:(NSString*)login
             password:(NSString*)password
              success:(void (^)())success
              failure:(void (^)( NSError *error))failure
{
    
    ServerInfo * serverInfo = [[ServerInfo alloc] initWithServerName:kGlobusServerName
                                                        serverDomain:kGlobusServerDomain];
    
    [serverInfo loginWithUser:login
                     password:password
                      success:^{
                          _activeServerInfo = serverInfo;
                          [appStorage setObject:serverInfo forKey:kActiveAccount];
                          if(success)
                              success();
                      } failure:^(NSError *error) {
                          if(failure)
                              failure(error);
                      }];
}
@end
