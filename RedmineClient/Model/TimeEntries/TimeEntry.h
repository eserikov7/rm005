//
//  TimeEntry.h
//  RedmineClient
//
//  Created by Евгений Сериков on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IssueModel.h"
#import "ProjectModel.h"

@interface TimeEntry : NSObject

@property(nonatomic)NSString    *Id;
@property(nonatomic)float        hours;
@property(nonatomic)NSString    *comments;
@property(nonatomic)NSDate      *spent_on;

@property(nonatomic)IssueModel    *issue;
@property(nonatomic)ProjectModel  *project;

//"created_on": "2015-02-05T11:18:24Z",
//"updated_on": "2015-02-05T11:18:24Z"

- (void)parce:(NSDictionary*)dict;

@end
