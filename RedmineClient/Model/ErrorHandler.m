//
//  ErrorHandler.m
//  ABBMobilePurse
//
//  Created by Евгений Сериков on 26.05.14.
//  Copyright (c) 2014 eserikov. All rights reserved.
//

#import "ErrorHandler.h"
#import "NetworkingManager.h"
#import "AppDelegate.h"

@implementation ErrorHandler
{
    UIAlertView * alert;
}

+ (ErrorHandler*)instance
{
    static ErrorHandler*inst = nil;
    if(inst == nil)
    {
        inst = [[ErrorHandler alloc] init];
    }
    return inst;
}
- (id)init
{
    self = [super init];
    alert = nil;
    return self;
}
- (void)handleOperation:(AFHTTPRequestOperation*) operation withError:(NSError*)error
{

    switch ([operation response].statusCode ) {
        case 500:
        {
            if([operation.responseObject isKindOfClass:[NSDictionary class]])
            {
                NSDictionary * dict = operation.responseObject;
                
                if(((NSString*)[dict objectForKey:@"Message"]).length>0)
                {
                    [self showAlert:[NSError errorWithDomain:@""
                                                        code:[operation error].code
                                                    userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"Message"],NSLocalizedDescriptionKey, nil]]];
                }
            }
        }
            break;
        case 404:
            /*
            [self showAlert:[NSError errorWithDomain:@""
                                                code:[operation error].code
                                            userInfo:[NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"IDS_NETWORK_ERROR", @""),NSLocalizedDescriptionKey, nil]]];
             */
            break;
        case 401:
        {
            [[NetworkingManager manager].operationQueue cancelAllOperations];
            
        }
            break;

        default:
            break;
    }
}

- (void)showAlert:(NSError*)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        @synchronized(self)
        {
            
            if(alert == nil)
            {
                
                alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"IDS_ERROR", @"")
                                                   message:error.localizedDescription
                                                  delegate:self
                                         cancelButtonTitle:@"Ok"
                                         otherButtonTitles: nil];
                [alert show];
                
                
            }
        }
    });
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    alert = nil;
}
@end
