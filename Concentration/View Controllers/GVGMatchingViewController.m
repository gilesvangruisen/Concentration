//
//  GVGMatchingViewController.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/27/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "GVGMatchingViewController.h"

@interface GVGMatchingViewController ()

@end

@implementation GVGMatchingViewController

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

    // Instantiate image view with same frame as view, to hold background image
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];

    // Set image of background view to greyed shattered pattern
    backgroundImageView.image = [UIImage imageNamed:@"MatchingBackground"];
    
    // Add background image view as subview
    [self.view addSubview:backgroundImageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
