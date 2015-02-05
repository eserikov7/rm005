//
//  IssueModel.h
//  RedmineClient
//
//  Created by Evgeny Serikov on 05.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IssueModel : NSObject

@property(nonatomic)NSInteger Id;
@property(nonatomic)NSString* subject;
@property(nonatomic)NSString* issueDescription;

- (void)parce:(NSDictionary*)dict;

@end
