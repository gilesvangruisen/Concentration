//
//  GVGMatchingViewController.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/27/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "GVGMatchingViewController.h"
#import "Person.h"
#import "PCLoadingView.h"
#import "NSArray+RandomSample.h"
#import "GVGCardButton.h"
#import "GVGCardGridView.h"
#import "UIView+Fade.h"
#import "GVGTutorialView.h"

@interface GVGMatchingViewController () <UIAlertViewDelegate, GVGCardGridDelegate>

// Holds all persons form which random six are pulled
@property (nonatomic, strong) NSArray *persons;

// Label holding the current score
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;

// The label for the word "Score" - to be faded in/out
@property (nonatomic, strong) IBOutlet UILabel *scoreWordLabel;

// Loading spinner
@property (nonatomic, strong) PCLoadingView *loadingView;

// Feedback for what is being loaded
@property (nonatomic, strong) UILabel *loadingLabel;

// Holds first card user selects in a given pair
@property (nonatomic, strong) GVGCardButton *cardToMatch;

@end

// Enum for alert view tag
typedef enum : NSUInteger {
    AVTNotEnoughConnections
} GVGAlertViewType;

@implementation GVGMatchingViewController
@synthesize modalView;

- (id)init
{
    self = [super initWithNibName:@"MatchingView" bundle:[NSBundle mainBundle]];
    if (self) {

        // Set initial score and label
        _score = 0;
        self.scoreLabel.text = @"0";

        // Begin loading persons
        [self loadPersons];

        // Check if user has seen tutorial, display tutorial view if not
        if (![[NSUserDefaults standardUserDefaults] valueForKey:@"seenTutorial"]) {

            // Pop in tutorial view

        }

    }
    return self;
}

- (void)loadPersons
{
    // Begin loading connections
    [Person publicPersonsWithSuccess:^(NSArray *persons) {

        // Check if we have enough persons to play
        if (persons.count >= 6) {

            // We have at least six, set to self.persons
            self.persons = persons;

            // Populate card
            [self populatePeopleCards];

        } else {

            // Not enough connections to play, alert user
            UIAlertView *notEnoughConnectionsAlert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"You must have at least six public connections to play." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];

            // Set tag so delegate knows how to react upon dismissal
            notEnoughConnectionsAlert.tag = AVTNotEnoughConnections;

            // Present alert
            [notEnoughConnectionsAlert show];

        }

    } failure:nil];
}

- (void)populatePeopleCards
{
    // Card grid should delegate to self
    self.cardGridView.delegate = self;

    // Populate card grid with six random persons
    self.cardGridView.persons = [self.persons randomSample:6];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{

    // Alert view dismissed, check tag
    switch (alertView.tag) {

        case AVTNotEnoughConnections:

            // Alert is for not enough connections, dismiss view controller
            [self dismissViewControllerAnimated:YES completion:nil];

            break;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Initialize loading view (80x80 centered)
    self.loadingView = [[PCLoadingView alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2) - 20, (self.view.frame.size.height / 2) - 40, 40, 40)];

    self.loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 2) - 100, (self.view.frame.size.height / 2) + 20, 200, 20)];

    self.loadingLabel.text = @"Loading Connections";
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
    self.loadingLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0f];

    [self.view addSubview:self.loadingLabel];

    // Add loading view as subview
    [self.view addSubview:self.loadingView];

}

- (void)setScore:(int)score
{
    _score = score;

    // Score label should shrink first
    POPSpringAnimation *scoreFirstShrinkAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scoreFirstShrinkAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    scoreFirstShrinkAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.7, 0.7)];

    // Upon shrink completion, set text and begin to grow
    scoreFirstShrinkAnimation.completionBlock = ^(POPAnimation *animation, BOOL completed) {
        self.scoreLabel.text = [NSString stringWithFormat:@"%i", score];

        POPSpringAnimation *scoreGrowAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scoreGrowAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.7, 0.7)];
        scoreGrowAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.8, 1.8)];

        // Upon grow completion, begin shrinking back to resting size
        scoreGrowAnimation.completionBlock = ^(POPAnimation *animation, BOOL completed) {

            POPSpringAnimation *scoreRestingShrinkAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
            scoreRestingShrinkAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.8, 1.8)];
            scoreRestingShrinkAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];

            [self.scoreLabel.layer pop_addAnimation:scoreRestingShrinkAnimation forKey:@"scoreLabel.scale"];
        };

        [self.scoreLabel.layer pop_addAnimation:scoreGrowAnimation forKey:@"scoreLabel.scale"];

    };

    [self.scoreLabel.layer pop_addAnimation:scoreFirstShrinkAnimation forKey:@"scoreLabel.scale"];
}

#pragma mark GVGCardGridDelegate

- (void)cardsWillAppear
{
    // Fade out animation
    POPBasicAnimation *basicFadeOutAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    basicFadeOutAnimation.fromValue = @(1);
    basicFadeOutAnimation.toValue = @(0);

    // Fade in animation
    POPBasicAnimation *basicFadeInAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    basicFadeInAnimation.fromValue = @(0);
    basicFadeInAnimation.toValue = @(1);

    // Fade in score and score word labels
    [self.scoreLabel fadeIn];
    [self.scoreWordLabel fadeIn];

    // Fade out loading text
    [self.loadingLabel fadeOut];

    // Fade out loading view
    [self.loadingView fadeOut];
}

- (void)didFlipCard:(GVGCardButton *)card
{
    // We only care if it's face up
    switch (card.flippedState) {
        case GVGFlippedStateFaceUp: {

            // Check if there is a card already flipped (needs match)
            if (self.cardToMatch) {

                // Two cards flipped, no longer safe to flip
                self.cardGridView.safeToFlip = NO;

                // Check if cards are
                [self attemptMatch:card];

            } else {

                // No card to match
                // Safe to flip another
                self.cardGridView.safeToFlip = YES;

                // Set card to match
                self.cardToMatch = card;
            }

            break;
        }
    }
}

- (void)attemptMatch:(GVGCardButton *)card
{
    // Pointer to first card picked
    GVGCardButton *cardToMatch = self.cardToMatch;

    // Set card to match property to nil in prep for next draw
    self.cardToMatch = nil;

    // Check if it's a match
    if (card.person.name == cardToMatch.person.name) {

        // Safe to flip again
        self.cardGridView.safeToFlip = YES;

        // Show cards for a sec
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            // Fade cards out after a second
            [cardToMatch fadeOut];
            [card fadeOut];

            // Call did match handler
            [self didMakeMatch:self.cardToMatch.person];

        });

    } else {

        // No match made
        self.cardGridView.safeToFlip = YES;

        // Call mismatch handler
        [self didMismatch];

        // Show cards for a sec
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            // Bounce cards back to resting pos
            [card bounceToScale:CGPointMake(1, 1) completion:nil];
            [cardToMatch bounceToScale:CGPointMake(1, 1) completion:nil];

            // Flip cards back over
            [self.cardGridView flipCards:@[cardToMatch, card]];

        });
    }
}

- (void)didMakeMatch:(Person *)person
{
    [self presentModalView:[GVGTutorialView new]];
    // Increase score by 2 points each time
    self.score += 2;

    // Check if winning score
    if (self.score == 12) {

        // All matches made, game is over
        UIAlertView *congrats = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:@"You made all the matches. Nice work!" delegate:nil cancelButtonTitle:@"Woohoo!" otherButtonTitles:nil];

        // Repopulate people cards
        [self populatePeopleCards];

        // Reset score
        self.score = 0;

        // Show alert
        [congrats show];
    }
}

- (void)didMismatch
{
    NSLog(@"NO MATCH");
}

- (void)presentModalView:(UIView<GVGModalViewDelegate> *)view
{
    self.modalView = view;
    [self.view addSubview:self.modalView];
}

- (void)dismissModalView
{
    [self.modalView removeFromSuperview];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
