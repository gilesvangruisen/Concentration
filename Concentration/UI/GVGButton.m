//
//  GVGButton.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/27/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "GVGButton.h"
#import <pop/POP.h>

@implementation GVGButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // Style the button: white semi-transparent bg, rounded corners, title text
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        self.layer.cornerRadius = 4.0f;
        self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0f];
        [self setTitleColor:[UIColor colorWithWhite:0.0f alpha:0.8f] forState:UIControlStateNormal];

        // Add touch down target
        [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
        
        // Add touch up targets
        [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)touchDown
{
    POPSpringAnimation *scaleSpringAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleSpringAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 0.9)];
    scaleSpringAnimation.springSpeed = 18.;
    scaleSpringAnimation.springBounciness = 18.;
    [self.layer pop_addAnimation:scaleSpringAnimation forKey:@"card.scale"];
}

- (void)touchUp
{
    POPSpringAnimation *scaleSpringAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleSpringAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    scaleSpringAnimation.springSpeed = 18.;
    scaleSpringAnimation.springBounciness = 18.;
    [self.layer pop_addAnimation:scaleSpringAnimation forKey:@"card.scale"];
}

@end
