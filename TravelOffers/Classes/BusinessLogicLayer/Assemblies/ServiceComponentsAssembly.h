//
//  ServiceComponentsAssembly.h
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol OfferPersistenceService;

@interface ServiceComponentsAssembly : NSObject

@property(nonatomic, strong) id<OfferPersistenceService> offerPersistenceService;

@end
