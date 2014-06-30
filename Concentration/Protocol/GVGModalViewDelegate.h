//
//  GVGModalViewDelegate.h
//  Concentration
//
//  Created by Giles Van Gruisen on 6/30/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GVGModalViewDelegate <NSObject>

// Visible modal view
@property (nonatomic, strong) UIView *modalView;

// Call on delegate to present modal view
- (void)presentModalView:(UIView *)view;

// Call on delegate to dismiss the view
- (void)dismissModalView;

- (void)signOut;

@end

@protocol GVGModalView <NSObject>

@property (nonatomic, strong) id<GVGModalViewDelegate> delegate;

@end
