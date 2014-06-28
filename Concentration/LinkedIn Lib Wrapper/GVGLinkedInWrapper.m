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
    // Maintain a shared, static instance of LIALinkedInApplication, set to nil initially
    static LIALinkedInApplication *linkedInApplication = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{

        // On first call, linkedInApplication will be nil
        if (!linkedInApplication) {

            // If first call, set linkedInApplication
            linkedInApplication = [LIALinkedInApplication applicationWithRedirectURL:@"http://fetchnotes.com/"
                                                                  clientId:@"773m1dw0zr4nyi" // API key
                                                              clientSecret:@"3WQIZkTWWK3AAtxG" // API secret
                                                                     state:@"a03Jf8d2cH29s0CdJ" // CORS token (forgery prevention)
                                                             grantedAccess:@[@"r_fullprofile", @"r_network"]];
        }
    });

    // Return client for static application
    return [LIALinkedInHttpClient clientForApplication:linkedInApplication presentingViewController:nil];
}

#pragma mark Authorization

+ (void)requestAuthorizationWithSuccess:(void(^)())success tokenFailure:(void(^)(NSError *error))tokenFailure authorizationFailure:(void(^)(NSError *error))authorizationFailure
{
    // Fetch initialized shared API client
    LIALinkedInHttpClient *client = [GVGLinkedInWrapper sharedAPIClient];

    // Present web view to authenticate with LinkedIn
    [client getAuthorizationCode:^(NSString *authorizationCode) {

        // Authentication successful, save the code to user defaults
        [[NSUserDefaults standardUserDefaults] setValue:authorizationCode forKey:@"authorizationCode"];

        // Request access token data for authorization code
        [client getAccessToken:authorizationCode success:^(NSDictionary *accessTokenData) {

            // Token data received, pull the access token itself
            NSString *accessToken = [accessTokenData objectForKey:@"access_token"];

            // Save the access token to user defaults
            [[NSUserDefaults standardUserDefaults] setValue:accessToken forKey:@"accessToken"];

            // Call success block
            success();

        } failure:tokenFailure];

    } cancel:nil failure:authorizationFailure];
}

// Wrapper to ensure authorized API calls
+ (void)confirmAuthorization:(void (^)(NSString *accessToken))success failure:(void (^)())failure {

    // Look up access token in user defaults
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"accessToken"];

    if (accessToken) {

        // Found access token, call success block (API call) with token
        success(accessToken);

    } else {

        // No access token found, log error
        NSLog(@"User must be authenticated before attempting to make a request.");

        // Call failure block (no token found)
        failure();
    }
}

#pragma mark API Calls

+ (void)getConnectionsWithSuccess:(void(^)(id connections))success failure:(void(^)(NSError *error))failure
{
    // Wrap call to ensure authorized request
    [self confirmAuthorization:^(NSString *accessToken) {

        // Build request URL with access token
        NSString *urlString = [NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~/connections:(id,picture-url,first-name,last-name,headline,location:(name))?oauth2_access_token=%@&format=json", accessToken];

        // Make authorized call to LinkedIn connections URL
        [[self sharedAPIClient] GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *result) {

            // Call succeeded, ensure we have connections
            if([result objectForKey:@"values"]) {

                // Call success block with connections
                success([result objectForKey:@"values"]);

            } else {

                // No connections, call failure
                NSError *error = [NSError errorWithDomain:@"Error loading connections" code:0 userInfo:nil];
                failure(error);

            }

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"FETCHING CONNECTIONS FAILURE WITH OBJECT: %@", operation.responseObject);
            NSLog(@"FETCHING CONNECTIONS FAILURE WITH ERROR: %@", error);
        }];
    } failure:nil];
}

@end
