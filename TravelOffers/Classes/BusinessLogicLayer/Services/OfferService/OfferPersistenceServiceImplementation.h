//
//  OfferServiceImplementation.h
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfferPersistenceService.h"

@protocol OfferNetworkService;


@interface OfferPersistenceServiceImplementation : NSObject<OfferPersistenceService>

@property(nonatomic, strong) id<OfferNetworkService> offerNetworkService;

@end
