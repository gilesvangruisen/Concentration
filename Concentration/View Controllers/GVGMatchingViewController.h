//
//  GVGMatchingViewController.h
//  Concentration
//
//  Created by Giles Van Gruisen on 6/27/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GVGCardButton;
@class GVGCardGridView;

@interface GVGMatchingViewController : UIViewController

// IBOutlet property to connect view to nib
@property (nonatomic, strong) IBOutlet UIView *view;

// Holds current score, setScore updates private property scoreLabel
@property (nonatomic) int score;

// View containing grid of cards
@property (nonatomic, strong) IBOutlet GVGCardGridView *cardGridView;

@end
