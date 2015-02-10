//
//  ActionsModel.h
//  RedmineClient
//
//  Created by Евгений Сериков on 09.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionInfo.h"

@interface ActionsModel : NSObject

@property(nonatomic, readonly)NSArray* actions;

- (void)addActionInfo:(ActionInfo*)actionInfo;

- (void)replaceActionInfo:(ActionInfo*)actionInfo;

- (void)saveState;
@end
