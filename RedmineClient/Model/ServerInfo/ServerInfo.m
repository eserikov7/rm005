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
#import "NetworkingManager.h"

@implementation ServerInfo

{
    NSString* accLogin;
    NSString* accPassword;
    NSString* apiKey;
    NSString* uid;
    NSString* firstName;
    NSString* lastName;
    TimeEntries* _timeEntries;
}
- (instancetype)initWithServerName:(NSString*)name
                      serverDomain:(NSString*)domain
{
    self = [super init];
    
    _serverName = name;
    _serverDomain = domain;
    
    return self;
}


- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        _serverName = [decoder decodeObjectForKey:@"_session"];
        _serverDomain = [decoder decodeObjectForKey:@"_serverDomain"];
        
        uid = [decoder decodeObjectForKey:@"uid"];
        accLogin = [decoder decodeObjectForKey:@"accLogin"];
        accPassword = [decoder decodeObjectForKey:@"accPassword"];
        apiKey = [decoder decodeObjectForKey:@"apiKey"];
        firstName = [decoder decodeObjectForKey:@"firstName"];
        lastName = [decoder decodeObjectForKey:@"lastName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_serverName forKey:@"_serverName"];
    [encoder encodeObject:_serverDomain forKey:@"_serverDomain"];
    
    [encoder encodeObject:uid forKey:@"uid"];
    [encoder encodeObject:accLogin forKey:@"accLogin"];
    [encoder encodeObject:accPassword forKey:@"accPassword"];
    [encoder encodeObject:apiKey forKey:@"apiKey"];
    [encoder encodeObject:firstName forKey:@"firstName"];
    [encoder encodeObject:lastName forKey:@"lastName"];
}

- (TimeEntries *)timeEntries
{
    if(_timeEntries == nil)
        _timeEntries = [[TimeEntries alloc] init];
    return _timeEntries;
}

- (NSString *)firstName
{
    return firstName;
}

- (NSString *)lastName
{
    return lastName;
}

- (NSString*)login
{
    return accLogin;
}

- (NSString*)password
{
    return accPassword;
}

- (NSString*)apiKey
{
    return apiKey;
}
- (NSURL*)url
{
    return [NSURL URLWithString:[kGlobusServerDomain stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (void)loginWithUser:(NSString*)login
             password:(NSString*)password
              success:(void (^)())success
              failure:(void (^)( NSError *error))failure
{
    
    
    NSURL*url = [self serverURLBy:kGlobusServerDomain login:login password:password];
    url = [ url URLByAppendingPathComponent:kUserInfo];
    
    accLogin = login;
    accPassword = password;
    [[NetworkingManager manager] GET:[url absoluteString]
                          parameters:nil
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 
                                 if([responseObject objectForKey:@"user"])
                                 {
                                     [self parce:[responseObject objectForKey:@"user"]];
                                 }
                                 accPassword = password;
                                 if(success)
                                     success();
                                 
                             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                 accLogin = login;
                                 if(failure)
                                     failure(error);
                             }];
}

- (void)updateAccountInfoSuccess:(void (^)())success
                         failure:(void (^)( NSError *error))failure
{

    NSURL*url = [self url];
    url = [ url URLByAppendingPathComponent:kUserInfo];
    [[NetworkingManager manager] GET:[url absoluteString]
                          parameters:nil
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                 
                                 if([responseObject objectForKey:@"user"])
                                 {
                                     [self parce:[responseObject objectForKey:@"user"]];
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
    accLogin = [dict objectForKey:@"login"];
    
    apiKey = [dict objectForKey:@"api_key"];
    
    uid = [dict objectForKey:@"id"];
    firstName = [dict objectForKey:@"firstname"];
    lastName = [dict objectForKey:@"lastname"];

}

- (NSURL*)serverURLBy:(NSString*)domain
                login:(NSString*)login
             password:(NSString*)password
{
    
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:domain];
    components.user = login;
    components.password = password;
    
    NSURL*url = [components URL];
    
    return url;
}

- (NSURL*)serverURLBy:(NSString*)domain
               apiKey:(NSString*)key
{
    return [NSURL URLWithString:[domain stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

@end
