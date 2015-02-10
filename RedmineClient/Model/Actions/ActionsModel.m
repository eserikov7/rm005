//
//  ActionsModel.m
//  RedmineClient
//
//  Created by Евгений Сериков on 09.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import "ActionsModel.h"
#import "ServersModel.h"

@implementation ActionsModel
{
    NSMutableArray * _actions;
}

- (instancetype)init
{
    self = [super init];
    
    _actions = [[ServersModel instance].storage objectForKey:@"ActionsModelActions"];
    if(_actions == nil)
        _actions = [NSMutableArray array];
    
    return self;
}


- (void)addActionInfo:(ActionInfo*)actionInfo
{
    if(actionInfo.Id == 0)
    {
        NSInteger maxId = 0;
        for(ActionInfo* act in _actions)
        {
            if(act.Id>maxId)
                maxId = act.Id;
        }
        actionInfo.Id = maxId+1;
    }

    [_actions addObject:actionInfo];
    
    [self saveState];
    
}

- (void)replaceActionInfo:(ActionInfo*)actionInfo
{
    [_actions replaceObjectAtIndex:[_actions indexOfObject:actionInfo] withObject:actionInfo];
    
    [self saveState];
}

- (void)saveState
{
    [[ServersModel instance].storage setObject:_actions forKey:@"ActionsModelActions"];
}

@end
