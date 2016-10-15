//
//  OfferService.h
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OfferPersistenceService <NSObject>

- (NSArray *)fetchOffersWithPredicate:(NSPredicate *)predicate;

@end
