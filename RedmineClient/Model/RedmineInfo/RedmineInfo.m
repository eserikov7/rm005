//
//  RedmineInfo.m
//  RedmineClient
//
//  Created by Евгений Сериков on 10.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "RedmineInfo.h"
#import "NetworkingManager.h"
#import "Constants.h"
#import "ServersModel.h"
#import "StatusModel.h"

@implementation RedmineInfo
{
    NSMutableArray* _statuses;
    NSMutableArray* _users;
    
}

- (NSArray *)statuses
{
    return _statuses;
}

- (NSArray*)users
{
    return _users;
}

- (void)loadInfoSuccess:(void (^)())success
                failure:(void (^)( NSError *error))failure
{
    
    NetworkingManager* manager = [NetworkingManager manager];
    
    NSURL * url = [[ServersModel activeServer].url URLByAppendingPathComponent:kIssueStatusesList];
    
    [manager GET:[[url absoluteString] stringByAppendingString:@"?limit=100"]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSMutableArray* resp = [[NSMutableArray alloc] init];
             
             for(NSDictionary*item in [responseObject objectForKey:@"issue_statuses"])
             {
                 StatusModel*user = [[StatusModel alloc] init];
                 [user parce:item];
                 [resp addObject:user];
             }
             
             for(StatusModel*item in _statuses)
             {
                 if(![resp containsObject:item])
                     [resp addObject:item];
             }
             _statuses = resp;
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
         }];
    
    
    url = [[ServersModel activeServer].url URLByAppendingPathComponent:kUsersList];
    
    [manager GET:[[url absoluteString] stringByAppendingString:@"?limit=100"]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSMutableArray* resp = [[NSMutableArray alloc] init];
             
             for(NSDictionary*item in [responseObject objectForKey:@"users"])
             {
                 UserModel*user = [[UserModel alloc] init];
                 [user parce:item];
                 [resp addObject:user];
             }
             
             for(UserModel*item in _users)
             {
                 if(![resp containsObject:item])
                     [resp addObject:item];
             }
             _users = resp;
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
         }];
    
    
    if(success)
        success();
}

@end
