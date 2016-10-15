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
#import "OfferModelObject.h"
#import "NetworkClient.h"

#define kStrURLBus @"https://api.myjson.com/bins/37yzm"
#define kStrURLFlight @"https://api.myjson.com/bins/w60i"
#define kStrURLTrains @"https://api.myjson.com/bins/3zmcy"

@implementation OfferNetworkServiceImplementation

#pragma mark - OfferNetworkService
- (void)refreshTrainOffersWithCompletionBlock:(OfferNetworkServiceCompletionBlock)block {
    NSURL *url = [NSURL URLWithString:kStrURLTrains];
    [self refreshOffersUsinURL:url WithCompletionBlock:block];
}

- (void)refreshBusOffersWithCompletionBlock:(OfferNetworkServiceCompletionBlock)block {
    NSURL *url = [NSURL URLWithString:kStrURLBus];
    [self refreshOffersUsinURL:url WithCompletionBlock:block];
}

- (void)refreshFlightOffersWithCompletionBlock:(OfferNetworkServiceCompletionBlock)block {
    NSURL *url = [NSURL URLWithString:kStrURLFlight];
    [self refreshOffersUsinURL:url WithCompletionBlock:block];
}

#pragma mark - Private
- (void)refreshOffersUsinURL:(NSURL*)url WithCompletionBlock:(OfferNetworkServiceCompletionBlock)block {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.networkClient sendRequest:request completionBlock:^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
        if (!block) {
            return;
        }
        if (error) {
            block(nil, error);
        } else {
            NSError *jsonError;
            id jsonArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (jsonError) {
                block(nil, jsonError);
            } else {
                block(jsonArr, nil);
            }
        }
    }];
}

@end
