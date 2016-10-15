//
//  OfferService.h
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OfferPlainObject;

typedef void(^RefreshOffersCompletionBlock)(NSError *error);

typedef NS_ENUM(NSUInteger, TravelMode) {
    TravelModeTrain = 1,
    TravelModeBus,
    TravelModeFlight
};

@protocol OfferPersistenceService <NSObject>


- (NSArray<OfferPlainObject*> *)fetchTrainOffers;
- (NSArray<OfferPlainObject*> *)fetchBusOffers;
- (NSArray<OfferPlainObject*> *)fetchFlightOffers;

- (void)refreshTrainOffersWithCompletionBlock:(RefreshOffersCompletionBlock)block;
- (void)refreshBusOffersWithCompletionBlock:(RefreshOffersCompletionBlock)block;
- (void)refreshFlightOffersWithCompletionBlock:(RefreshOffersCompletionBlock)block;

@end
