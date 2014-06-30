//
//  NSMutableArray+RandomShuffle.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/29/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "NSMutableArray+RandomShuffle.h"

@implementation NSMutableArray (RandomShuffle)

- (void)shuffle
{
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform(remainingCount);
        [self exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

@end
