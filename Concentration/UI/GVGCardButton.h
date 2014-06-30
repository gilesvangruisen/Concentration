//
//  GVGCardButton.h
//  Concentration
//
//  Created by Giles Van Gruisen on 6/28/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import <pop/POP.h>

typedef enum : NSUInteger {
    GVGFlippedStateFaceDown,
    GVGFlippedStateFaceUp
} GVGFlippedState;

typedef enum : NSUInteger {
    GVGCardTypeName,
    GVGCardTypePicture
} GVGCardType;

@protocol GVGCardButtonDelegate;

@interface GVGCardButton : UIButton

// Flipped state: whether the card is face down or face up
@property (nonatomic) NSUInteger flippedState;

@property (nonatomic, strong) id<GVGCardButtonDelegate> delegate;

// Type of card, i.e. name or picture
@property (nonatomic) NSUInteger type;

// Person object attached to card
@property (nonatomic, strong) Person *person;

// "Back" of the card, i.e. side showing art
@property (nonatomic, strong) UIView *faceDownView;

// "Front" or "face" of the card, i.e. showing name or picture
@property (nonatomic, strong) UIView *faceUpView;

- (void)flip;

- (void)bounceToScale:(CGPoint)scale completion:(void(^)(POPAnimation *, BOOL))completion;

@end

@protocol GVGCardButtonDelegate <NSObject>

@required

// YES if 1 or 0 cards currently flipped, NO otherwise
@property (nonatomic, assign) BOOL safeToFlip;

- (void)didFlipCard:(GVGCardButton *)card;

@end