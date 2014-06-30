//
//  GVGTutorialView.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/30/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "GVGTutorialView.h"
#import "GVGButton.h"

@implementation GVGTutorialView

- (id)init
{
    self = [super initWithFrame:CGRectMake(20, ([UIScreen mainScreen].bounds.size.height / 2) - 220, 280, 440)];
    if (self) {
        // White background
        self.backgroundColor = [UIColor whiteColor];

        // Build how to header label, stylize w/ avenir next medium, 21pt
        UILabel *howToLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, self.bounds.size.width - (140), 36)];
        howToLabel.text = @"How to Play";
        howToLabel.textAlignment = NSTextAlignmentCenter;
        howToLabel.textColor = [UIColor colorWithRed:0.38 green:0.56 blue:0.68 alpha:1];
        howToLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:21.0f];

        // Add how to header as subview
        [self addSubview:howToLabel];

        // Build text view with playing instructions, stylize w/ avenir next regular, 16pt
        UITextView *instructionsTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 80, self.bounds.size.width - 40, self.bounds.size.height - 200)];
        instructionsTextView.text = @"Concentration is a matching game to help you get to know your connections on LinkedIn.\n\nThere are twelve cards, each containing a name or a picture.\n\nMatch the name with the corresponding picture (or vice-versa) to make a match.";
        instructionsTextView.editable = false;
        instructionsTextView.font = [UIFont fontWithName:@"AvenirNext-Regular" size:16.0f];
        instructionsTextView.textColor = [UIColor colorWithRed:0.38 green:0.56 blue:0.68 alpha:1];
        instructionsTextView.userInteractionEnabled = false;

        // Add background image as subview
        [self addSubview:instructionsTextView];

        GVGButton *dismissButton = [self dismissButton];
        // Add button as subview
        [self addSubview:dismissButton];

        // Add target delegate to dismiss modal
        [dismissButton addTarget:self.delegate action:@selector(dismissModalView) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (GVGButton *)dismissButton
{
    // Init gvg button with blueish background
    GVGButton *dismissButton = [[GVGButton alloc] initWithFrame:CGRectMake(30, self.bounds.size.height - 80, self.bounds.size.width - 60, 50)];
    [dismissButton setBackgroundColor:[UIColor colorWithRed:0.38 green:0.56 blue:0.68 alpha:1]];
    
    // Set title label to something not so boring
    [dismissButton setTitle:@"Let's go!" forState:UIControlStateNormal];
    [dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    return dismissButton;
}

@end
