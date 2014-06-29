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

@interface GVGCardGridView ()

@property (nonatomic, strong) NSArray *cards;

@end

@implementation GVGCardGridView

- (id)init
{
    self = [super init];
    if (self) {

        // Initially set opacity to 0
        self.layer.opacity = 0;

        // Init mutably array containing all card buttons
        self.cards = @[self.card0, self.card1, self.card2, self.card3, self.card4, self.card5, self.card6, self.card7, self.card8, self.card9, self.card10, self.card11];

    }
    return self;
}


- (void)fadeInCards
{
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @(0);
    opacityAnimation.toValue = @(1);
    [self.layer pop_addAnimation:opacityAnimation forKey:@"cardGrid.opacity"];
}

- (void)setPersons:(NSArray *)persons
{
    _persons = persons; // Six persons

    // Init temporary mutable copy of cards to be shuffled and populated
    NSMutableArray *cardsToPopulate = [self.cards mutableCopy];

    // Shuffle the cards so order is random
    [cardsToPopulate shuffle];

    // Loop over persons and add name to one card, picture to another
    for (Person *person in _persons) {

        // Pop last object off temp cards
        GVGCardButton *nameCard = [cardsToPopulate lastObject];
        [cardsToPopulate removeLastObject];

        // Populate card with current person
        nameCard.person = person;

        // Card is to be used as name
        nameCard.type = GVGCardTypeName;

        // Pop last object off temp cards
        GVGCardButton *faceCard = [cardsToPopulate lastObject];
        [cardsToPopulate removeLastObject];

        // Populate card with current person
        faceCard.person = person;

        // Card is picture card
        faceCard.type = GVGCardTypePicture;
    }

    [self fadeInCards];
}

@end
