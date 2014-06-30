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
    POPBasicAnimation *fadeInAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    fadeInAnimation.fromValue = @(0);
    fadeInAnimation.toValue = @(1);
    [self.layer pop_addAnimation:fadeInAnimation forKey:@"layer.fadein"];
}

- (void)fadeOut
{
    POPBasicAnimation *fadeOutAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    fadeOutAnimation.fromValue = @(1);
    fadeOutAnimation.toValue = @(0);
    [self.layer pop_addAnimation:fadeOutAnimation forKey:@"layer.fadeout"];
}

@end
