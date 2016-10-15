//
//  NetworkClientsAssembly.m
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import "NetworkClientsAssembly.h"
#import "NetworkClientImplementation.h"

@implementation NetworkClientsAssembly

- (id<NetworkClient>)commonNetworkClient {
    return [[NetworkClientImplementation alloc] init];
}

@end
