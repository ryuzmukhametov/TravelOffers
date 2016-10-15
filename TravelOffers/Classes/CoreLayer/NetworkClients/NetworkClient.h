//
//  NetworkClient.h
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^NetworkClientCompletionBlock)(NSHTTPURLResponse *response, NSData *data, NSError *error);

@protocol NetworkClient <NSObject>

- (void)sendRequest:(NSURLRequest *)request completionBlock:(NetworkClientCompletionBlock)block;

@end
