//
//  GVGCardGridView.h
//  Concentration
//
//  Created by Giles Van Gruisen on 6/29/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GVGCardButton.h"

// Forward declare delegate protocol to use in properties
@protocol GVGCardGridDelegate;

@interface GVGCardGridView : UIView <GVGCardButtonDelegate>

@property (nonatomic, strong) NSArray *cards;

// Array containing six persons to populate cards
@property (nonatomic, strong) NSArray *persons;

// Delegate to receive events
@property (nonatomic, strong) id<GVGCardGridDelegate> delegate;

// Property/outlet for each of twelve cards
@property (nonatomic, strong) IBOutlet GVGCardButton *card0;
@property (nonatomic, strong) IBOutlet GVGCardButton *card1;
@property (nonatomic, strong) IBOutlet GVGCardButton *card2;
@property (nonatomic, strong) IBOutlet GVGCardButton *card3;
@property (nonatomic, strong) IBOutlet GVGCardButton *card4;
@property (nonatomic, strong) IBOutlet GVGCardButton *card5;
@property (nonatomic, strong) IBOutlet GVGCardButton *card6;
@property (nonatomic, strong) IBOutlet GVGCardButton *card7;
@property (nonatomic, strong) IBOutlet GVGCardButton *card8;
@property (nonatomic, strong) IBOutlet GVGCardButton *card9;
@property (nonatomic, strong) IBOutlet GVGCardButton *card10;
@property (nonatomic, strong) IBOutlet GVGCardButton *card11;

// Pass an array of cards to be flipped
- (void)flipCards:(NSArray *)cards;

@end

// Delegate protocol
@protocol GVGCardGridDelegate <NSObject>

@optional

// Called when persons are loaded and about to fade in
- (void)cardsWillAppear;

@required

// Called when a user flips a card
- (void)didFlipCard:(GVGCardButton *)card;

// Called when a user makes an incorrect match
- (void)didMismatch;

@end