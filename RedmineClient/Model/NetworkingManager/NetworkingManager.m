//
//  NetworkingManager.m
//  ABBMobilePurse
//
//  Created by Евгений Сериков on 22.05.14.
//  Copyright (c) 2014 eserikov. All rights reserved.
//

#import "NetworkingManager.h"
#import "ErrorHandler.h"
#import "ServersModel.h"
@implementation NetworkingManager

+(NetworkingManager*)manager
{
    NetworkingManager* netManager = [super manager];
    [netManager.requestSerializer setAuthorizationHeaderFieldWithUsername:[ServersModel activeServer].login password:[ServersModel activeServer].password];
    return netManager;
}

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [super GET:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[ErrorHandler instance] handleOperation:operation withError:error];
        if(failure)
            failure(operation,error);
    }];
}

- (AFHTTPRequestOperation *)HEAD:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [super HEAD:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[ErrorHandler instance] handleOperation:operation withError:error];
        if(failure)
            failure(operation,error);
    }];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [super POST:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[ErrorHandler instance] handleOperation:operation withError:error];
        if(failure)
            failure(operation,error);
    }];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [super POST:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters constructingBodyWithBlock:block success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[ErrorHandler instance] handleOperation:operation withError:error];
        if(failure)
            failure(operation,error);
    }];
}

- (AFHTTPRequestOperation *)PUT:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [super PUT:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[ErrorHandler instance] handleOperation:operation withError:error];
        if(failure)
            failure(operation,error);
    }];
}

- (AFHTTPRequestOperation *)PATCH:(NSString *)URLString
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [super PATCH:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[ErrorHandler instance] handleOperation:operation withError:error];
        if(failure)
            failure(operation,error);
    }];
}

- (AFHTTPRequestOperation *)DELETE:(NSString *)URLString
                        parameters:(NSDictionary *)parameters
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    return [super DELETE:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters success:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[ErrorHandler instance] handleOperation:operation withError:error];
        if(failure)
            failure(operation,error);
    }];
}

@end
