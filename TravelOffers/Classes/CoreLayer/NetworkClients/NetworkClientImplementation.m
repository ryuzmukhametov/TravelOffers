//
//  NetworkClientImplementation.m
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import "NetworkClientImplementation.h"

@interface NetworkClientImplementation()
@property(nonatomic, strong) NSURLSession *session;
@end

@implementation NetworkClientImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        self.session = session;
    }
    return self;
}


- (void)sendRequest:(NSURLRequest *)request completionBlock:(NetworkClientCompletionBlock)block {        
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
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
