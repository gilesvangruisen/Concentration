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

#define CARD_OFFSET_Y = 0


- (id)initWithPerson:(Person *)person index:(NSInteger)index
{
    self = [super init];
    if (self) {
        
        self.index = index;
        
        // Initial state is flipped with face down
        self.flippedState = GVGFlippedStateFaceDown;

        // Set self.person to person passed with init
        self.person = person;

        // Add subviews in order: faceUp at botom, faceDown above
        [self addSubview:self.faceUpView];
        [self addSubview:self.faceDownView];
        
        [self addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchUpOutside) forControlEvents:UIControlEventTouchUpOutside];

    }
    return self;
}

- (void)touchDown
{
    POPSpringAnimation *scaleSpringAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleSpringAnimation.fromValue = @(1);
    scaleSpringAnimation.toValue = @(0.8);
    [self.layer pop_addAnimation:scaleSpringAnimation forKey:@"card.scale"];
}

- (void)touchUpOutside
{
    
}

- (void)flipCard
{
    // Check card state to determine animation
    switch (self.flippedState) {
        case GVGFlippedStateFaceDown:

            // Flip and fade out

            break;
            
        case GVGFlippedtateFaceUp:
            
            break;
    }
}

- (void)layoutSubviews
{
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CardArt"]];

    [self addSubview:self.backgroundImageView];
}

@end
