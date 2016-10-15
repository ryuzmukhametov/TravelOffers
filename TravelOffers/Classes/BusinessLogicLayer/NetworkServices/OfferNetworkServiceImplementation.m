//
//  OfferNetworkServiceImplementation.m
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import "OfferNetworkServiceImplementation.h"
#import "NetworkClient.h"
#import "NetworkClientImplementation.h"
#import <MagicalRecord/MagicalRecord.h>
#import "OfferModelObject.h"
#import "NetworkClient.h"

@implementation OfferNetworkServiceImplementation

- (void)refreshOffersWithCompletionBlock:(OfferNetworkServiceCompletionBlock)block {
    
}
/*
- (void)loadOffersWithCompletionBlock {
    NetworkClientImplementation *nc = [[NetworkClientImplementation alloc] init];
    //nc sendRequest: completionBlock:
    
    
    
    NSManagedObjectContext *rootSavingContext = [NSManagedObjectContext MR_rootSavingContext];
    [rootSavingContext performBlock:^{
        OfferModelObject *offer = [OfferModelObject MR_createEntity];
        
//        CompoundOperationBase *compoundOperation = [self.eventOperationFactory getEventsOperationWithQuery:listQuery
//                                                                                             modelObjectId:modelObjectId];
//        
//        compoundOperation.resultBlock = ^void(id data, NSError *error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                completionBlock(error);
//            });
//        };
//        
//        [self.operationScheduler addOperation:compoundOperation];
    }];
    
}
*/
@end
