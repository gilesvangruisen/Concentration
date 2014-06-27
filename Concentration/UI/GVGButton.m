//
//  GVGButton.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/27/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "GVGButton.h"

@implementation GVGButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // Style the button: white semi-transparent bg, rounded corners, title text
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        self.layer.cornerRadius = 4.0f;
        self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0f];
        [self setTitleColor:[UIColor colorWithWhite:0.0f alpha:0.8f] forState:UIControlStateNormal];

    }
    return self;
}

@end
