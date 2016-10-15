//
//  OfferNetworkServiceImplementation.m
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import "OfferNetworkServiceImplementation.h"
#import "NetworkClient.h"
#import "NetworkClientImplementation.h"
#import <MagicalRecord/MagicalRecord.h>
#import "OfferModelObject.h"
#import "NetworkClient.h"

#define kStrURLBus @"https://api.myjson.com/bins/37yzm"
#define kStrURLFlight @"https://api.myjson.com/bins/w60i"
#define kStrURLTrains @"https://api.myjson.com/bins/3zmcy"

@implementation OfferNetworkServiceImplementation

- (void)refreshOffersWithCompletionBlock:(OfferNetworkServiceCompletionBlock)block {
    NSURL *url = [NSURL URLWithString:kStrURLBus];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.networkClient sendRequest:request completionBlock:^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
        
        if (response.statusCode == 200 ) {

            NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
            [rootSavingContext performBlock:^{

                NSError *jsonError;
                id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                NSArray *offersArr = obj;
                for (NSDictionary *offerDict in offersArr) {
                    OfferModelObject *offer = [OfferModelObject MR_createEntity];
                    offer.arrivalTime = offerDict[@"arrival_time"];
                    offer.departureTime = offerDict[@"departure_time"];
                    offer.offerId = offerDict[@"id"];
                    offer.mode = @1;
                    offer.numberOfStops = offerDict[@"number_of_stops"];
                    offer.priceInEuros = offerDict[@"price_in_euros"];
                    offer.providerLogo = offerDict[@"provider_logo"];
                }
            }];
            
            
        } else {
            // TODO: check if error nil
            if (error && block) {
                block(error);
            }
        }
        
        
        
        
        
        ;
    }];
}
/*
- (void)loadOffersWithCompletionBlock {
    NetworkClientImplementation *nc = [[NetworkClientImplementation alloc] init];
    //nc sendRequest: completionBlock:
    
    
    
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
 
}
*/
@end
