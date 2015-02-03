//
//  UILoginVC.m
//  RedmineClient
//
//  Created by Evgeny Serikov on 03.02.15.
//  Copyright (c) 2015 Globus Inc. All rights reserved.
//
#import "UILoginVC.h"

#import "Constants.h"
#import "UIView+Roundify.h"
#import "ServersModel.h"

@implementation UILoginVC
{
    IBOutlet UITextField* loginField;
    IBOutlet UITextField* passwordField;
    IBOutlet UIButton* loginButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColorLoginBackground;
    
    loginButton.layer.cornerRadius = kCorterRadius;
    loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
    loginButton.layer.borderWidth = 1.0;
    
    
    [loginField addRoundedCorners: UIRectCornerTopLeft|UIRectCornerTopRight withRadii:CGSizeMake(kCorterRadius, kCorterRadius)];
    [passwordField addRoundedCorners: UIRectCornerBottomLeft|UIRectCornerBottomRight withRadii:CGSizeMake(kCorterRadius, kCorterRadius)];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (IBAction)loginAction:(id)sender
{
    [[ServersModel instance] loginWithUser:loginField.text
                                  password:passwordField.text
                                   success:^{
                                       UIAlertView* alert= [[UIAlertView alloc] initWithTitle:@""
                                                                                      message:[NSString stringWithFormat:NSLocalizedString(@"login_welcome", @""),
                                                                                               [ServersModel activeServer].firstName,
                                                                                               [ServersModel activeServer].lastName]
                                                                                     delegate:nil
                                                                            cancelButtonTitle:NSLocalizedString(@"ids_ok", @"")
                                                                            otherButtonTitles: nil];
                                       [alert show];
                                       
                                       UIViewController*vc = [self.storyboard instantiateViewControllerWithIdentifier:@"appTabBarController"];
                                       [UIApplication sharedApplication].delegate.window.rootViewController = vc;
                                       [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
                                       
                                   } failure:^(NSError *error) {
                                   
                                       UIAlertView* alert= [[UIAlertView alloc] initWithTitle:@""
                                                                                      message:error.localizedDescription
                                                                                     delegate:nil
                                                                            cancelButtonTitle:NSLocalizedString(@"ids_ok", @"")
                                                                            otherButtonTitles: nil];
                                       [alert show];
                                   }];
}

@end
