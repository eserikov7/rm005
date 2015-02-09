//
//  ActionInfo.h
//  RedmineClient
//
//  Created by Евгений Сериков on 09.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "StatusModel.h"
#import "ProjectModel.h"

@interface ActionInfo : NSObject

@property(nonatomic)NSInteger Id;

@property(nonatomic)NSString* name;

@property(nonatomic)UserModel* assigned_to;

@property(nonatomic)StatusModel* status;

@property(nonatomic)ProjectModel* projectModel;

@property(nonatomic)NSInteger done_ratio;

@property(nonatomic)NSString* defaultDescription;

@end
