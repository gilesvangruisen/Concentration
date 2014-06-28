//
//  GVGLinkedInWrapper.h
//  Concentration
//
//  Created by Giles Van Gruisen on 6/27/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import <Foundation/Foundation.h>

// Forward declare LinkedIn library classes to be included in implementation
@class LIALinkedInHttpClient;
@class LIALinkedInApplication;

@interface GVGLinkedInWrapper : NSObject

// Returns API client instance, requests authentication if not yet auth'd
+ (LIALinkedInHttpClient *)sharedAPIClient;

+ (void)getCurrentUser;

+ (void)getConnectionsWithSuccess:(void(^)(id connections))success failure:(void(^)(NSError *error))failure;

@end
