//
//  GVGCardGridView.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/29/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "GVGCardGridView.h"
#import "Person.h"
#import "NSMutableArray+RandomShuffle.h"
#import "UIView+Fade.h"

@interface GVGCardGridView ()

@end

@implementation GVGCardGridView
@synthesize safeToFlip;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

        // Initially set opacity to 0
        self.layer.opacity = 0;
        safeToFlip = YES;

    }
    return self;
}


- (void)fadeInCards
{
    // Basic opacity enter animation
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @(0);
    opacityAnimation.toValue = @(1);

    // Add animation
    [self.layer pop_addAnimation:opacityAnimation forKey:@"cardGrid.opacity"];
}

- (void)setPersons:(NSArray *)persons
{
    _persons = persons; // Six persons

    // Set cards array
    self.cards = @[self.card0, self.card1, self.card2, self.card3, self.card4, self.card5, self.card6, self.card7, self.card8, self.card9, self.card10, self.card11];

    // Init temporary mutable copy of cards to be shuffled and populated
    NSMutableArray *cardsToPopulate = [self.cards mutableCopy];

    // Shuffle the cards so order is random
    [cardsToPopulate shuffle];

    // Loop over persons and add name to one card, picture to another
    for (Person *person in _persons) {

        // Pop last two objects off temp cards, one for name, one for face
        GVGCardButton *nameCard = [cardsToPopulate lastObject];
        [cardsToPopulate removeLastObject];

        GVGCardButton *faceCard = [cardsToPopulate lastObject];
        [cardsToPopulate removeLastObject];

        // Set type, name and picture respectively
        nameCard.type = GVGCardTypeName;
        faceCard.type = GVGCardTypePicture;

        // Initial flipped state is face down
        nameCard.flippedState = GVGFlippedStateFaceDown;
        faceCard.flippedState = GVGFlippedStateFaceDown;

        // Populate cards with current person
        nameCard.person = person;
        faceCard.person = person;

        // Set delegates
        nameCard.delegate = self;
        faceCard.delegate = self;

        // Opacity
        [nameCard fadeTo:0.5];
        [faceCard fadeTo:0.5];

    }

    // Check if delegate implements cardsWillView and call it if so
    if ([self.delegate respondsToSelector:@selector(cardsWillAppear)]) {
        [self.delegate cardsWillAppear];
    }

    // Cards loaded, fade in
    [self fadeInCards];
}

- (void)didFlipCard:(GVGCardButton *)card
{
    [self.delegate didFlipCard:card];
}

- (void)flipCards:(NSArray *)cards
{
    for (GVGCardButton *card in cards) {
        [card flip];
    }
}

@end
