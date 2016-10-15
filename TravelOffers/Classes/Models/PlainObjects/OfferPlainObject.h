//
//  OfferPlainObject.h
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfferPlainObject : NSObject

@property (nonatomic, strong) NSString *arrivalTime;
@property (nonatomic, strong) NSString *departureTime;
@property (nonatomic, strong) NSNumber *offerId;
@property (nonatomic, strong) NSNumber *mode;
@property (nonatomic, strong) NSNumber *numberOfStops;
@property (nonatomic, strong) NSString *priceInEuros;
@property (nonatomic, strong) NSString *providerLogo;


@end
