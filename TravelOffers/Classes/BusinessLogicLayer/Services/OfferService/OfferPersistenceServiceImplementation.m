//
//  OfferServiceImplementation.m
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import "OfferPersistenceServiceImplementation.h"

#import "OfferModelObject.h"
#import <MagicalRecord/MagicalRecord.h>
#import "OfferNetworkService.h"

@implementation OfferPersistenceServiceImplementation


- (NSArray *)fetchOffersWithPredicate:(NSPredicate *)predicate {
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    NSArray *offers = [OfferModelObject MR_findAllWithPredicate:predicate inContext:context];
    return offers;
}

- (NSArray<OfferPlainObject*> *)fetchBusOffers {
    return [self fetchOffersWithPredicate:nil];
}

- (void)refreshBusOffers {
    [self.offerNetworkService refreshOffersWithCompletionBlock:^(NSError *error) {
        // TODO: call error
    }];
}
@end
