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

CGRect boxes[4];

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.layer.opacity = 1;
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
    // Fade
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @(0.0);
    anim.toValue = @(1.0);
    //    anim.duration = []
    [self pop_addAnimation:anim forKey:@"opacity"];
}

- (void)fadeOut
{
    // Fade
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @(1.0);
    anim.toValue = @(0.0);
    //    anim.duration = []
    [self pop_addAnimation:anim forKey:@"opacity"];
}


@end
