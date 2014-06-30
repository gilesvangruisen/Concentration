//
//  UIView+Fade.h
//  Concentration
//
//  Created by Giles Van Gruisen on 6/30/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Fade)

- (void)fadeIn;

- (void)fadeOut;

- (void)fadeTo:(CGFloat)toValue;

@end
