//
//  ProjectsManager.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "ProjectsManager.h"
#import "NetworkingManager.h"
#import "ServersModel.h"
#import "Constants.h"



@implementation ProjectsManager

- (void)loadProjectsSuccess:(void (^)())success
                    failure:(void (^)( NSError *error))failure
{
    NSURL* url = [[ServersModel activeServer].url URLByAppendingPathComponent:kProjectsList];
    
    
    NetworkingManager* manager = [NetworkingManager manager];
    
    [manager GET:[[url absoluteString] stringByAppendingString:@"?limit=100"]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             if(responseObject)
             {
                 [self parce:responseObject];
             }
             
             if(success)
                 success();
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if(failure)
                 failure(error);
         }];
    
}

- (void)parce:(NSDictionary*)dict
{
    if ([dict objectForKey:@"projects"]) {
        
        NSMutableArray* items = [NSMutableArray array];
        for(NSDictionary*itemDict in [dict objectForKey:@"projects"])
        {
            ProjectModel * entry = [[ProjectModel alloc] init];
            [entry parce:itemDict];
            [items addObject:entry];
        }
        _projects = items;
    }
    
    
}


@end
