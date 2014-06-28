//
//  Person.m
//  Concentration
//
//  Created by Giles Van Gruisen on 6/27/14.
//  Copyright (c) 2014 Fetchnotes. All rights reserved.
//

#import "Person.h"
#import "NSArray+RandomSample.h"
#import "GVGLinkedInWrapper.h"

@implementation Person


+ (void)publicPersonsWithSuccess:(void(^)(NSArray *persons))success failure:(void(^)(NSError *error))failure
{
    // Fetch all connections with api lib wrapper
    [GVGLinkedInWrapper getConnectionsWithSuccess:^(NSArray *connections) {

        // Init empty mutable array to hold Person objects
        NSMutableArray *persons = [@[] mutableCopy];

        // Loop over each of twelve connections to init, populate Person and add to twelvePersons
        for (NSDictionary *connection in connections) {

            // Destructure connection into properties: (firstName, lastName, pictureURL, headline, location)
            NSString *firstName = [connection objectForKey:@"firstName"];
            NSString *lastName = [connection objectForKey:@"lastName"];
            NSString *pictureURL = [connection objectForKey:@"pictureUrl"];
            NSString *headline = [connection objectForKey:@"headline"];
            NSString *location = [[connection objectForKey:@"location"] objectForKey:@"name"];

            // Ensure person has at least first name and picture, either headline or location for hint
            if (firstName && pictureURL && (headline || location)) {

                // Connection is public, init/populate Person
                Person *publicPerson = [Person new];

                // Concatenate first, last name and set to name for person
                publicPerson.name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];

                // Set picture url for person
                publicPerson.pictureURL = pictureURL;

                // Set hint for person (headline if available, otherwise location)
                publicPerson.hint = headline ? headline : location;
                
                // Person populated, add to persons to be returned
                [persons addObject:publicPerson];

            } // else connection is private (witout name, picture or either headline or location), move on

        }
        
        success(persons);
        
    } failure:failure];
}

@end
