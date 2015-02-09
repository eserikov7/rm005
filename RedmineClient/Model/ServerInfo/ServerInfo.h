//
//  ServerInfo.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 03.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimeEntries.h"
#import "ProjectsManager.h"
#import "ActionsModel.h"

@interface ServerInfo : NSObject

@property(nonatomic,readonly) NSURL *url;

@property(nonatomic,readonly) NSString *login;
@property(nonatomic,readonly) NSString *password;
@property(nonatomic,readonly) NSString *apiKey;
@property(nonatomic,readonly) NSString *firstName;
@property(nonatomic,readonly) NSString *lastName;

@property(nonatomic) NSDate *pushDate;
@property(nonatomic) BOOL pushAtHolidays;

@property(nonatomic,readonly) NSString *serverName;
@property(nonatomic,readonly) NSString *serverDomain;

@property(nonatomic,readonly)TimeEntries * timeEntries;
@property(nonatomic,readonly)ProjectsManager * projectsManager;
@property(nonatomic,readonly)ActionsModel *actionsModel;

- (instancetype)initWithServerName:(NSString*)serverName
                      serverDomain:(NSString*)serverDomain;

- (void)updateAccountInfoSuccess:(void (^)())success
                         failure:(void (^)( NSError *error))failure;

- (void)loginWithUser:(NSString*)login
             password:(NSString*)password
              success:(void (^)())success
              failure:(void (^)( NSError *error))failure;
@end
