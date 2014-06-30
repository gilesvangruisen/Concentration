//
//  NSArray+RandomSample.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/27/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "NSArray+RandomSample.h"

@implementation NSArray (RandomSample)

- (NSArray *)randomSample:(int)count {
    if ([self count] < count) {
        return nil;
    } else if ([self count] == count) {
        return self;
    }
    
    NSMutableSet* selection = [[NSMutableSet alloc] init];
    
    while ([selection count] < count) {
        id randomObject = [self objectAtIndex: arc4random() % [self count]];
        [selection addObject:randomObject];
    }
    
    return [selection allObjects];
}

@end