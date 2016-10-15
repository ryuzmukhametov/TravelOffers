//
//  OfferPlainObject.h
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfferPlainObject : NSObject

@property (nonatomic, copy, readwrite) NSString *arrivalTime;
@property (nonatomic, copy, readwrite) NSString *departureTime;
@property (nonatomic, copy, readwrite) NSNumber *offerId;
@property (nonatomic, copy, readwrite) NSNumber *mode;
@property (nonatomic, copy, readwrite) NSNumber *numberOfStops;
@property (nonatomic, copy, readwrite) NSNumber *priceInEuros;
@property (nonatomic, copy, readwrite) NSString *providerLogo;

@property (nonatomic, strong) NSString *duration;
@end
