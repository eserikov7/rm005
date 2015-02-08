//
//  IssueModel.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectModel.h"
#import "TrackerModel.h"
#import "StatusModel.h"
#import "PriorityModel.h"
#import "UserModel.h"

@interface IssueModel : NSObject

@property(nonatomic)NSInteger Id;
@property(nonatomic)NSString* subject;
@property(nonatomic)NSString* issueDescription;
@property(nonatomic)ProjectModel* project;

@property(nonatomic)TrackerModel* tracker;
@property(nonatomic)StatusModel* status;
@property(nonatomic)PriorityModel* priority;
@property(nonatomic)UserModel* author;
@property(nonatomic)UserModel* assigned_to;

@property(nonatomic)NSInteger done_ratio;
@property(nonatomic)NSDate* created_on;
@property(nonatomic)NSDate* updated_on;

- (void)parce:(NSDictionary*)dict;

@end
