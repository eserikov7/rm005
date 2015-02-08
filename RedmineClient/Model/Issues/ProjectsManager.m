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

- (void)loadProjectsOffset:(NSInteger)offset
                     limit:(NSInteger)limit
                   success:(void (^)())success
                    failure:(void (^)( NSError *error))failure
{
    NSURL* url = [[ServersModel activeServer].url URLByAppendingPathComponent:kProjectsList];
    
    
    NetworkingManager* manager = [NetworkingManager manager];
    
    [manager GET:[NSString stringWithFormat:[[url absoluteString] stringByAppendingString:@"?limit=%ld&offset=%ld"],limit,offset]
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
        
        _projectsCount = [[dict objectForKey:@"total_count"] integerValue];
        
        NSMutableArray* resp = [[NSMutableArray alloc] init];
        for(NSDictionary*itemDict in [dict objectForKey:@"projects"])
        {
            ProjectModel * entry = [[ProjectModel alloc] init];
            [entry parce:itemDict];
            [resp addObject:entry];
        }
        
        for(ProjectModel*item in _projects)
        {
            if(![resp containsObject:item])
                [resp addObject:item];
        }
        _projects = resp;

    }
}


@end
