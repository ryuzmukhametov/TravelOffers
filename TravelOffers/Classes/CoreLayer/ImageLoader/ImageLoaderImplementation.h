//
//  ImageLoaderImplementation.h
//  TravelOffers
//
//  Created by Rustam Yuzmukhametov on 16/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageLoader.h"

@protocol NetworkClient;

@interface ImageLoaderImplementation : NSObject<ImageLoader>

@property(nonatomic, strong) id<NetworkClient> networkClient;

@end
