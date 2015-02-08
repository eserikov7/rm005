//
//  ProjectsManager.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProjectModel.h"

@interface ProjectsManager : NSObject

@property(nonatomic,readonly)NSArray* projects;
@property(nonatomic,readonly)NSInteger projectsCount;

- (void)loadProjectsOffset:(NSInteger)offset
                     limit:(NSInteger)limit
                   success:(void (^)())success
                    failure:(void (^)( NSError *error))failure;
@end
