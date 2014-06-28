//
//  GVGAuthenticationViewController.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/27/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "GVGLinkedInWrapper.h"
#import <LIALinkedInApplication.h>
#import <LIALinkedInHttpClient.h>
#import "GVGAuthenticationViewController.h"
#import "GVGButton.h"
#import "GVGMatchingViewController.h"
#import <pop/POP.h>

@interface GVGAuthenticationViewController ()

@property (nonatomic, strong) GVGButton *authenticationButton;

@end

@implementation GVGAuthenticationViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Instantiate background image view with launch image for seamless transition
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];

    // Set the proper background image depending on screen size to prevent stretching
    if (self.view.frame.size.height == 568) {
        backgroundImageView.image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    } else {
        backgroundImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }

    // Add target to authenticate with linked in upon tapping
    [self.authenticationButton addTarget:self action:@selector(authenticate) forControlEvents:UIControlEventTouchUpInside];

    // Spring animate the authentication button position y from offscreen origin up to 400
    POPSpringAnimation *buttonEnterPositionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    buttonEnterPositionAnimation.fromValue = @(self.view.frame.size.height);
    buttonEnterPositionAnimation.toValue = @(400);

    // Animate opacity form 0 to 1 while simultaenously sliding up
    POPBasicAnimation *buttonEnterOpacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    buttonEnterOpacityAnimation.fromValue = @(0);
    buttonEnterOpacityAnimation.toValue = @(1);

    // Add background image view at bottom of view stack
    [self.view addSubview:backgroundImageView];

    // Add authentication button as subview
    [self.view addSubview:self.authenticationButton];

    // Add position and opacity animations to button, will begin immediately
    [self.authenticationButton.layer pop_addAnimation:buttonEnterPositionAnimation forKey:@"authButton.enterPosition"];
    [self.authenticationButton.layer pop_addAnimation:buttonEnterOpacityAnimation forKey:@"authButton.enterOpacity"];
}

- (GVGButton *)authenticationButton {
    _authenticationButton = _authenticationButton ? _authenticationButton : [GVGButton new];

    // Define frame properties for authentication button
    CGFloat authenticationButtonWidth = 180;
    CGFloat authenticationButtonHeight = 50;
    CGFloat authenticationButtonX = (self.view.frame.size.width / 2) - (authenticationButtonWidth / 2);

    // Set authentication button frame based on above properties (start offscreen)
    _authenticationButton.frame = CGRectMake(authenticationButtonX, self.view.frame.size.height, authenticationButtonWidth, authenticationButtonHeight);

    // Set title to "Sign in with LinkedIn"
    [_authenticationButton setTitle:@"Sign in with LinkedIn" forState:UIControlStateNormal];

    return _authenticationButton;
}

- (void)authenticate
{
    // Authorize with linkedin wrapper, passing blocks for each success, auth failure, token failure
    __block void (^successBlock)() = ^{

        // New instance of matching view controller
        GVGMatchingViewController *matchingViewController = [GVGMatchingViewController new];

        // Transition style should be horizontal flip
        matchingViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

        // Present matching view controller
        [self presentViewController:matchingViewController animated:YES completion:nil];

    };

    [GVGLinkedInWrapper requestAuthorizationWithSuccess:^{

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), successBlock);

    } tokenFailure:^(NSError *error) {

        // Access token query failed. Log error
        NSLog(@"Quering accessToken failed %@", error);

        // Notify user with alert that auth failed and they may try again
        UIAlertView *failureAlert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Something went wrong. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [failureAlert show];

    } authorizationFailure:^(NSError *error) {

        // Authentication failed. Log error
        NSLog(@"Authentication failed with error: %@", error);

        // Notify user with alert that auth failed and they may try again
        UIAlertView *failureAlert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Could not connect to LinkedIn. Please check your Internet connceiton and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [failureAlert show];

    }];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
