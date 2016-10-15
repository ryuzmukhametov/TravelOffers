//
//  OfferNetworkService.h
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OfferNetworkServiceCompletionBlock)(NSArray *jsonArr, NSError *error);

@protocol OfferNetworkService <NSObject>

- (void)refreshTrainOffersWithCompletionBlock:(OfferNetworkServiceCompletionBlock)block;
- (void)refreshBusOffersWithCompletionBlock:(OfferNetworkServiceCompletionBlock)block;
- (void)refreshFlightOffersWithCompletionBlock:(OfferNetworkServiceCompletionBlock)block;

@end
