//
//  PCLoadingView.m
//  Remarkable
//
//  Created by Giles Van Gruisen on 4/28/14.
//  Copyright (c) 2014 Giles Van Gruisen. All rights reserved.
//

#import "PCLoadingView.h"
#import <pop/POP.h>

@interface PCLoadingView ()

@property (nonatomic) int currentBox;
@property (nonatomic) NSMutableArray *boxes;

@end

@implementation PCLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIImageView* animatedImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    animatedImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"One"],
                                         [UIImage imageNamed:@"Two"],
                                         [UIImage imageNamed:@"Three"],
                                         [UIImage imageNamed:@"Four"], nil];
    animatedImageView.animationDuration = 0.5f;
    animatedImageView.animationRepeatCount = 0;
    [animatedImageView startAnimating];
    [self addSubview:animatedImageView];
}

- (void)fadeIn
{
    // Fade in animation
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @(0.0);
    anim.toValue = @(1.0);
    [self pop_addAnimation:anim forKey:@"loadingView.opacity"];
}

- (void)fadeOut
{
    // Fade out animation
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @(1.0);
    anim.toValue = @(0.0);
    [self pop_addAnimation:anim forKey:@"loadingView.opacity"];
}

@end
