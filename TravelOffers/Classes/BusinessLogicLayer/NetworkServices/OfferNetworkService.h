//
//  OfferNetworkService.h
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^OfferNetworkServiceCompletionBlock)(NSError *error);

@protocol OfferNetworkService <NSObject>

- (void)refreshOffersWithCompletionBlock:(OfferNetworkServiceCompletionBlock)block;

@end
