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

@interface GVGMatchingViewController () <UIAlertViewDelegate, GVGCardGridDelegate>

@property (nonatomic, strong) NSArray *persons;

@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;

@property (nonatomic, strong) PCLoadingView *loadingView;
@property (nonatomic, strong) UILabel *loadingLabel;

@property (nonatomic) NSInteger currentScore;


@end

typedef enum : NSUInteger {
    AVTNotEnoughConnections
} GVGAlertViewType;

@implementation GVGMatchingViewController

- (id)init
{
    self = [super initWithNibName:@"MatchingView" bundle:[NSBundle mainBundle]];
    if (self) {

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
    // Init cards grid view
    self.cardGridView.persons = [self.persons randomSample:6];
    self.cardGridView.delegate = self;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
