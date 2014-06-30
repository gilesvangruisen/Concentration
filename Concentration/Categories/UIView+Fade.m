//
//  UIView+Fade.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/30/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "UIView+Fade.h"
#import <pop/POP.h>

@implementation UIView (Fade)

- (void)fadeIn
{
    [self fadeTo:1];
}

- (void)fadeOut
{
    [self fadeTo:0];
}

- (void)fadeTo:(CGFloat)toValue
{
    POPBasicAnimation *fadeToAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    fadeToAnimation.fromValue = @(self.layer.opacity);
    fadeToAnimation.toValue = @(toValue);
    [self.layer pop_addAnimation:fadeToAnimation forKey:@"fadeTo"];
}

@end
