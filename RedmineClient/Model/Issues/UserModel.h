//
//  UserModel.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 08.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property(nonatomic) NSInteger Id;
@property(nonatomic) NSString* name;

- (void)parce:(NSDictionary*)dict;

@end
