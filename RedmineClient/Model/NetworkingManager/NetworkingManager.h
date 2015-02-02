//
//  NetworkingManager.h
//  ABBMobilePurse
//
//  Created by Евгений Сериков on 22.05.14.
//  Copyright (c) 2014 eserikov. All rights reserved.
//

#import <AFNetworking.h>

@interface NetworkingManager : AFHTTPRequestOperationManager

+(NetworkingManager*)manager;
@end
