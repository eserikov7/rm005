//
//  ProjectModel.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "ProjectModel.h"
#import "NetworkingManager.h"
#import "ServersModel.h"
#import "Constants.h"
#import "IssueModel.h"

@implementation ProjectModel
{
    NSArray*_issues;
}

- (void)loadIssuesSuccess:(void (^)())success
                  failure:(void (^)( NSError *error))failure
{
    NSURL* url = [[ServersModel activeServer].url URLByAppendingPathComponent:kIssuesList];
    
    NetworkingManager* manager = [NetworkingManager manager];
    

    [manager GET:[NSString stringWithFormat:[[url absoluteString] stringByAppendingString:@"?project_id=%ld&limit=100"],self.Id]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             if([responseObject objectForKey:@"issues"])
             {
                 NSMutableArray* resp = [[NSMutableArray alloc] init];
                 for(NSDictionary*item in [responseObject objectForKey:@"issues"])
                 {
                     IssueModel*issue = [[IssueModel alloc] init];
                     [issue parce:item];
                     [resp addObject:issue];
                 }
                 _issues = resp;
             }
             
             if(success)
                 success();
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if(failure)
                 failure(error);
         }];

}

- (NSArray *)issues
{
    return _issues;
}

- (void)parce:(NSDictionary*)dict
{
    self.Id = [[dict objectForKey:@"id"] integerValue];
    self.name = [dict objectForKey:@"name"];
    self.projectDescription = [dict objectForKey:@"description"];
    self.identifier = [dict objectForKey:@"identifier"];
    self.status = [[dict objectForKey:@"status"] intValue];
}


@end
