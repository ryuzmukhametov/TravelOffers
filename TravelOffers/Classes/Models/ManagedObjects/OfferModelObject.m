//
//  OfferModelObject.m
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import "OfferModelObject.h"

@implementation OfferModelObject
@dynamic arrivalTime;
@dynamic departureTime;
@dynamic offerId;
@dynamic mode;
@dynamic numberOfStops;
@dynamic priceInEuros;
@dynamic providerLogo;


+ (NSString*)entityName {
    return @"Offer";
}


@end
