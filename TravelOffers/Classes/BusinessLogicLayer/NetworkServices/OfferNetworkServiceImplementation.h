//
//  OfferNetworkServiceImplementation.h
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfferNetworkService.h"

@protocol NetworkClient;

@interface OfferNetworkServiceImplementation : NSObject<OfferNetworkService>

@property(nonatomic, strong) id<NetworkClient> networkClient;

@end
