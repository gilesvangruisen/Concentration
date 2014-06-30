//
//  GVGTutorialView.h
//  Concentration
//
//  Created by Giles Van Gruisen on 6/30/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GVGModalViewDelegate.h"

@interface GVGTutorialView : UIView

@property (nonatomic, strong) id<GVGModalViewDelegate> delegate;

@end
