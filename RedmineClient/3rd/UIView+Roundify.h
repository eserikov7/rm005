//
//  UIView+Roundify.h
//  MedHap
//
//  Created by Евгений Сериков on 03.03.14.
//  Copyright (c) 2014 eserikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Roundify)

-(void)addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;
-(CALayer*)maskForRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;

@end