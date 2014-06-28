//
//  GVGLinkedInWrapper.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/27/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "GVGLinkedInWrapper.h"
#import <LIALinkedInApplication.h>
#import <LIALinkedInHttpClient.h>

@implementation GVGLinkedInWrapper

+ (LIALinkedInHttpClient *)sharedAPIClient
{
    static LIALinkedInApplication *linkedInApplication = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!linkedInApplication) {
            linkedInApplication = [LIALinkedInApplication applicationWithRedirectURL:@"http://fetchnotes.com/"
                                                                  clientId:@"773m1dw0zr4nyi" // API key
                                                              clientSecret:@"3WQIZkTWWK3AAtxG" // API secret
                                                                     state:@"a03Jf8d2cH29s0CdJ" // CORS token (forgery prevention)
                                                             grantedAccess:@[@"r_fullprofile", @"r_network"]];
        }
    });

    return [LIALinkedInHttpClient clientForApplication:linkedInApplication presentingViewController:nil];
}

+ (void)getCurrentUser
{
    [self confirmAuthorization:^(NSString *accessToken) {
        [[self sharedAPIClient] GET:[NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~?oauth2_access_token=%@&format=json", accessToken] parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
            NSLog(@"current user %@", result);
        }        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed to fetch current user %@", error);
        }];
    } failure:nil];
}

+ (void)getConnectionsWithSuccess:(void(^)(id connections))success failure:(void(^)(NSError *error))failure
{
    [self confirmAuthorization:^(NSString *accessToken) {
        NSLog(@"%@", accessToken);
        NSString *urlString = [NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~/connections:(id)?oauth2_access_token=%@&format=json", accessToken];

        [[self sharedAPIClient] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {
            success([result objectForKey:@"values"]);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", operation.responseObject);
            NSLog(@"FETCHING CONNECTIONS FAILURE WITH ERROR: %@", error);
        }];
    } failure:nil];
}

+ (void)confirmAuthorization:(void (^)(NSString *accessToken))success failure:(void (^)())failure {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [userDefaults valueForKey:@"accessToken"];

    if (accessToken) {
        success(accessToken);
    } else {
        NSLog(@"User must be authenticated before attempting to make a request.");
        failure();
    }
}

@end
