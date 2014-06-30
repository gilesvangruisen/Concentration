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
        // White background, corner radius
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // Background image to hold tutorial img (text)
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    backgroundImageView.image = [UIImage imageNamed:@"Tutorial"];

    // Add background image as subview
    [self addSubview:backgroundImageView];

    // Init gvg button with blueish background
    GVGButton *dismissButton = [[GVGButton alloc] initWithFrame:CGRectMake(30, self.bounds.size.height - 80, self.bounds.size.width - 60, 50)];
    dismissButton.backgroundColor = [UIColor colorWithRed:0.38 green:0.56 blue:0.68 alpha:0.6];

    // Set title label to something not so boring
    [dismissButton setTitle:@"Let's go!" forState:UIControlStateNormal];
    dismissButton.titleLabel.textColor = [UIColor whiteColor];

    // Add button as subview
    [self addSubview:dismissButton];

    // Add target delegate to dismiss modal
    [dismissButton addTarget:self.delegate action:@selector(dismissModalView) forControlEvents:UIControlEventTouchUpInside];
}

@end
