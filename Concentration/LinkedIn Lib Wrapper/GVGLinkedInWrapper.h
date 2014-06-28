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

// Returns shared API client instance
+ (LIALinkedInHttpClient *)sharedAPIClient;

// Initial authorization with return blocks for successful auth, token failure (failed ot gen token), authorization failure (usually connection failure)
+ (void)requestAuthorizationWithSuccess:(void(^)())success tokenFailure:(void(^)(NSError *error))tokenFailure authorizationFailure:(void(^)(NSError *error))authorizationFailure;

// Fetches all of current user's connections asynchronously, returns them through success block
+ (void)getConnectionsWithSuccess:(void(^)(id connections))success failure:(void(^)(NSError *error))failure;

@end
