//
//  NetworkClientsAssembly.h
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkClient.h"

@interface NetworkClientsAssembly : NSObject

@property(nonatomic, strong) id<NetworkClient> commonNetworkClient;

@end
