//
//  GVGCardButton.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/28/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "GVGCardButton.h"

@interface GVGCardButton ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation GVGCardButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

        // Initial state is flipped with face down
        self.flippedState = GVGFlippedStateFaceDown;

        // Add subviews in order: faceUp at botom, faceDown above
        [self addSubview:self.faceUpView];
        [self addSubview:self.faceDownView];

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

- (void)layoutSubviews
{
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardArt"]];

    [self addSubview:self.backgroundImageView];
}

@end
