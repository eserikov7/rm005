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
#import "UserModel.h"

@implementation ProjectModel
{
    NSArray* _issues;
    NSArray* _users;
}

- (BOOL)isEqual:(id)obj
{
    if([obj isKindOfClass:[self class]])
        return self.Id == ((ProjectModel*)obj).Id;
    return NO;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    
    self = [super init];
    if (self) {
        _Id = [decoder decodeIntegerForKey:@"_Id"];
        _name = [decoder decodeObjectForKey:@"_name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:_Id forKey:@"_Id"];
    [encoder encodeObject:_name forKey:@"_name"];
}

- (void)loadIssuesOffset:(NSInteger)offset
                   limit:(NSInteger)limit
                 success:(void (^)())success
                  failure:(void (^)( NSError *error))failure
{
    NSURL* url = [[ServersModel activeServer].url URLByAppendingPathComponent:kIssuesList];
    
    NetworkingManager* manager = [NetworkingManager manager];
    

    [manager GET:[NSString stringWithFormat:[[url absoluteString] stringByAppendingString:@"?project_id=%ld&limit=%ld&offset=%ld"],self.Id,limit,offset]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             if([responseObject objectForKey:@"issues"])
             {
                 _issuesCount = [[responseObject objectForKey:@"total_count"] integerValue];
                 NSMutableArray* resp = [[NSMutableArray alloc] init];
                 for(NSDictionary*item in [responseObject objectForKey:@"issues"])
                 {
                     IssueModel*issue = [[IssueModel alloc] init];
                     [issue parce:item];
                     [resp addObject:issue];
                 }
                 
                 for(IssueModel*item in _issues)
                 {
                     if(![resp containsObject:item])
                         [resp addObject:item];
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

- (void)loadUsersSuccess:(void (^)())success
                 failure:(void (^)( NSError *error))failure
{
    NSURL* url = [[[ServersModel activeServer].url URLByAppendingPathComponent:[NSString stringWithFormat:@"projects/%ld",(long)self.Id]]URLByAppendingPathComponent:kMembershipsList];
    NetworkingManager* manager = [NetworkingManager manager];
    [manager GET:[[url absoluteString] stringByAppendingString:@"?limit=100"]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSMutableArray* resp = [[NSMutableArray alloc] init];
             
             for(NSDictionary*item in [responseObject objectForKey:@"memberships"])
             {
                 UserModel*user = [[UserModel alloc] init];
                 [user parce:[item objectForKey:@"user"]];
                 [resp addObject:user];
             }
             
             for(UserModel*item in _users)
             {
                 if(![resp containsObject:item])
                     [resp addObject:item];
             }
             _users = resp;
             
             if(success)
                 success();
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             if(failure)
                 failure(error);
         }];
}

- (NSArray *)users
{
    return _users;
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
