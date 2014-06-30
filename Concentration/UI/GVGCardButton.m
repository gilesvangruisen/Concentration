//
//  GVGCardButton.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/28/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "GVGCardButton.h"
#import "UIView+Fade.h"

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
        [self addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)touchDown
{
    // Shrink with spring animation
    [self bounceToScale:CGPointMake(0.8, 0.8) completion:nil];
}

- (void)touchUpInside
{
    // User completed a tap inside, flip the card
    [self flip];

    // Grow card then spring back to resting position
    [self bounceToScale:CGPointMake(1.2, 1.2) completion:^(POPAnimation *animation, BOOL completed) {
        [self bounceToScale:CGPointMake(1, 1) completion:nil];
    }];
}

- (void)touchUp
{
    [self bounceToScale:CGPointMake(1, 1) completion:nil];
}

- (void)flip
{
    switch (self.flippedState) {
        case GVGFlippedStateFaceDown: {
            self.flippedState = GVGFlippedStateFaceUp;
            [self.faceUpView fadeIn];

            break;
        }

        case GVGFlippedStateFaceUp: {

            self.flippedState = GVGFlippedStateFaceDown;
            [self.faceUpView fadeOut];

            break;
        }
    }
}

- (void)setPerson:(Person *)person
{
    _person = person;

    // Set background image
    UIImageView *faceDownView = [[UIImageView alloc] initWithFrame:self.bounds];
    faceDownView = [[UIImageView alloc] initWithFrame:self.bounds];
    faceDownView.image = [UIImage imageNamed:@"CardArt"];
    self.faceDownView = faceDownView;

    // Init faceUpView
    self.faceUpView = [[UIView alloc] initWithFrame:self.bounds];

    // faceUpView should be initially invisible
    self.faceUpView.layer.opacity = 0;

    // Ensure card still tappable when faceUpView visible
    self.faceUpView.userInteractionEnabled = NO;
    self.faceUpView.exclusiveTouch = NO;

    switch (self.type) {
        case GVGCardTypeName: {

            // Text view, styled, w/ person's name, be added as faceUpView subview
            UITextView *nameTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 15, 74, 54)];
            nameTextView.scrollEnabled = false;
            nameTextView.text = self.person.name;
            nameTextView.textAlignment = NSTextAlignmentCenter;
            nameTextView.backgroundColor = [UIColor whiteColor];

            // Add label as subview of faceUpView
            [self.faceUpView addSubview:nameTextView];

            break;
        }

        case GVGCardTypePicture: {

            // Image view to hold portrait
            UIImageView *pictureView = [[UIImageView alloc] initWithFrame:self.bounds];

            // Set image view image to image loaded from picture url
            pictureView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.person.pictureURL]]];

            // Add image view as subview of faceUpView
            [self.faceUpView addSubview:pictureView];

            break;
        }
    }

    [self addSubview:self.faceDownView];
    [self addSubview:self.faceUpView];
}

- (void)layoutSubviews
{
    // Stylize cards with bg, corner radius, shadow
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 6.0f;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.2f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 3.0f;

    // Subviews should clip to rounded corners
    self.clipsToBounds = YES;
}

- (void)bounceToScale:(CGPoint)scale completion:(void(^)(POPAnimation *, BOOL))completion
{
    // Build animation to spring card to scale
    POPSpringAnimation *scaleSpringAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleSpringAnimation.toValue = [NSValue valueWithCGPoint:scale];

    // Animation should be quicker and bouncier
    scaleSpringAnimation.springSpeed = 18.;
    scaleSpringAnimation.springBounciness = 18.;

    // Allow a completion block (e.g. another animation)
    scaleSpringAnimation.completionBlock = completion;

    // Set (start) the animation
    [self.layer pop_addAnimation:scaleSpringAnimation forKey:@"card.scale"];
}

@end
