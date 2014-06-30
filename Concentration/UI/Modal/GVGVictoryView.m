//
//  GVGVictoryView.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/30/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "GVGVictoryView.h"
#import "GVGButton.h"

@implementation GVGVictoryView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(20, ([UIScreen mainScreen].bounds.size.height / 2) - 175, 280, 351)];
    if (self) {
        // White background
        self.backgroundColor = [UIColor whiteColor];

        // Build how to header label, stylize w/ avenir next medium, 21pt
        UILabel *victoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, self.bounds.size.width - (140), 36)];
        victoryLabel.text = @"Victory!";
        victoryLabel.textAlignment = NSTextAlignmentCenter;
        victoryLabel.textColor = [UIColor colorWithRed:0.38 green:0.56 blue:0.68 alpha:1];
        victoryLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:21.0f];
        
        // Add how to header as subview
        [self addSubview:victoryLabel];
        
        // Build text view with playing instructions, stylize w/ avenir next regular, 16pt
        UITextView *lookAtYouTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 80, self.bounds.size.width - 40, self.bounds.size.height - 200)];
        lookAtYouTextView.text = @"Look at you, networking guru!\n\nPlay again?";
        lookAtYouTextView.editable = false;
        lookAtYouTextView.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
        lookAtYouTextView.textColor = [UIColor colorWithRed:0.38 green:0.56 blue:0.68 alpha:1];
        lookAtYouTextView.userInteractionEnabled = false;
        lookAtYouTextView.textAlignment = NSTextAlignmentCenter;
        
        // Add background image as subview
        [self addSubview:lookAtYouTextView];

        // Init gvg button with blueish background for play again
        GVGButton *dismissButton = [[GVGButton alloc] initWithFrame:CGRectMake(30, self.bounds.size.height - 160, self.bounds.size.width - 60, 50)];
        dismissButton.backgroundColor = [UIColor colorWithRed:0.38 green:0.56 blue:0.68 alpha:0.6];

        // Set title label to something not so boring
        [dismissButton setTitle:@"Let's go!" forState:UIControlStateNormal];
        dismissButton.titleLabel.textColor = [UIColor whiteColor];

        // Add button as subview
        [self addSubview:dismissButton];

        // Add target delegate to dismiss modal
        [dismissButton addTarget:self.delegate action:@selector(dismissModalView) forControlEvents:UIControlEventTouchUpInside];

        // Init gvg button with blueish background
        GVGButton *signOutButton = [[GVGButton alloc] initWithFrame:CGRectMake(30, self.bounds.size.height - 80, self.bounds.size.width - 60, 50)];
        signOutButton.backgroundColor = [UIColor colorWithRed:0.38 green:0.56 blue:0.68 alpha:0.6];

        // Set title label to something not so boring
        [signOutButton setTitle:@"Sign Out" forState:UIControlStateNormal];
        [signOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        // Add button as subview
        [self addSubview:signOutButton];

        // Add target self with action to sign out
        [signOutButton addTarget:self action:@selector(signOut) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)signOut
{
    // Check if delegate has signout, call it
    if ([self.delegate respondsToSelector:@selector(signOut)]) {
        [self.delegate performSelector:@selector(signOut)];
    }
}

@end
