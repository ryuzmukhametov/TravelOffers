//
//  NetworkClientImplementation.m
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import "NetworkClientImplementation.h"

@implementation NetworkClientImplementation

- (void)sendRequest:(NSURLRequest *)request completionBlock:(NetworkClientCompletionBlock)block {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (block) {
            NSHTTPURLResponse *serverResponse = nil;
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                serverResponse = (NSHTTPURLResponse *)response;
            }
            block(serverResponse, data, error);
        }
    }];
    [dataTask resume];
    
}


@end
