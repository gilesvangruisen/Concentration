//
//  GVGAuthenticationViewController.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/27/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "GVGAuthenticationViewController.h"

@interface GVGAuthenticationViewController ()

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

    // Add background image view as subview
    [self.view addSubview:backgroundImageView];
}


@end
