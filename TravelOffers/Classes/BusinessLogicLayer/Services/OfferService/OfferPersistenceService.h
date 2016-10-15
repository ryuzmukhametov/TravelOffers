//
//  OfferService.h
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OfferPlainObject;

@protocol OfferPersistenceService <NSObject>

- (NSArray *)fetchOffersWithPredicate:(NSPredicate *)predicate;

- (NSArray<OfferPlainObject*> *)fetchBusOffers;

- (void)refreshBusOffers;

@end
