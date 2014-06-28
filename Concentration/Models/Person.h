//
//  Person.h
//  Concentration
//
//  Created by Giles Van Gruisen on 6/27/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *pictureURL;

@property (nonatomic, strong) NSString *hint;

+ (void)publicPersonsWithSuccess:(void(^)(NSArray *persons))success failure:(void(^)(NSError *error))failure;

@end
