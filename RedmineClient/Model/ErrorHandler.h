//
//  ErrorHandler.h
//  ABBMobilePurse
//
//  Created by Евгений Сериков on 26.05.14.
//  Copyright (c) 2014 eserikov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface ErrorHandler : NSObject<UIAlertViewDelegate>
+ (ErrorHandler*)instance;
- (void)handleOperation:(AFHTTPRequestOperation*) operation withError:(NSError*)error;

@end
