//
//  RedmineInfo.h
//  RedmineClient
//
//  Created by Евгений Сериков on 10.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RedmineInfo : NSObject

@property(nonatomic)NSArray *statuses;
@property(nonatomic)NSArray *users;


- (void)loadInfoSuccess:(void (^)())success
                failure:(void (^)( NSError *error))failure;

@end
