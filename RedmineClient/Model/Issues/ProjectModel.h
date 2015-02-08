//
//  ProjectModel.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectModel : NSObject

@property(nonatomic) NSInteger Id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* identifier;
@property(nonatomic) NSString* projectDescription;
@property(nonatomic) int status;

@property(nonatomic,readonly)NSArray* childProjects;

@property(nonatomic,readonly)NSInteger issuesCount;
@property(nonatomic,readonly)NSArray* issues;

- (void)loadIssuesOffset:(NSInteger)offset
                   limit:(NSInteger)limit
                 success:(void (^)())success
                 failure:(void (^)( NSError *error))failure;

- (void)parce:(NSDictionary*)dict;

@end
