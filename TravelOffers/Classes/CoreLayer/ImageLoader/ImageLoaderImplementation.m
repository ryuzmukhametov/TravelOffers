//
//  ImageLoaderImplementation.m
//  TravelOffers
//
//  Created by Rustam Yuzmukhametov on 16/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import "ImageLoaderImplementation.h"
#import "NetworkClient.h"

@interface ImageLoaderImplementation()
@property(nonatomic, strong) NSMutableSet<NSString*>  *erroredKeys;
@property(nonatomic, strong) NSMutableSet<NSString*>  *activeKeys;
@property(nonatomic, strong) NSCache<NSString*, UIImage*> *imageCache;
@end

@implementation ImageLoaderImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.erroredKeys = [[NSMutableSet alloc] init];
        self.activeKeys = [[NSMutableSet alloc] init];
        self.imageCache = [[NSCache alloc] init];
    }
    return self;
}

#pragma mark - ImageLoader
- (void)loadImageByURL:(NSURL*)URL complete:(LoadImageCompletionBlock)block {
    if (URL == nil) {
        return;
    }
    
    NSString *key = [self buildKeyByURL:URL];
    
    if ([self.imageCache objectForKey:key] || [self.erroredKeys containsObject:key] || [self.activeKeys containsObject:key]) {
        return;
    }
    [self.activeKeys addObject:key];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    __weak typeof(self) welf = self;
    [self.networkClient sendRequest:request completionBlock:^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
        [welf processResponse:response data:data error:error complete:block];
    }];
    
}

- (UIImage*)loadedImageByURL:(NSURL*)URL {
    NSString *key = [self buildKeyByURL:URL];
    UIImage *image = [self.imageCache objectForKey:key];
    if (image) {
        return image;
    }
    image = [self imageFromDiskByKey:key];
    if (image) {
        [self.imageCache setObject:image forKey:key];
        return image;
    }
    return nil;
}

#pragma mark - Private
- (NSString*)filePathForImages {
    NSArray *myPathList = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *myPath = [myPathList  objectAtIndex:0];
    myPath = [myPath stringByAppendingPathComponent:@"image_cache"];
    NSError *error;
    BOOL res = [[NSFileManager defaultManager] createDirectoryAtPath:myPath withIntermediateDirectories:YES attributes:0 error:&error];
    if (!res) {
        DDLogError(@"can't create directory, error: %@", error);
    }
    return myPath;
}

- (UIImage*)imageFromDiskByKey:(NSString*)key {
    NSString *path = [self filePathForImages];
    path = [path stringByAppendingPathComponent:key];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        return [UIImage imageWithData:data];
    }
    return nil;
}

- (void)saveDataImage:(NSData*)dataImage withKey:(NSString*)key {
    NSString *path = [self filePathForImages];
    path = [path stringByAppendingPathComponent:key];
    NSError *error;
    BOOL res = [dataImage writeToFile:path options:0 error:&error];

    if (!res) {
        DDLogError(@"can't save image %@", error);        
    }
}


- (NSString*)buildKeyByURL:(NSURL*)URL {
    NSString *key = [NSNumber numberWithUnsignedInteger:URL.absoluteString.hash].stringValue;
    return key;
}

- (void)processResponse:(NSHTTPURLResponse*)response data:(NSData*)data error:(NSError*)error complete:(LoadImageCompletionBlock)block {
    NSString *key = [self buildKeyByURL:response.URL];
    [self.activeKeys removeObject:key];
    
    if (error || data == nil) {
        [self.erroredKeys addObject:key];
        if (block) {
            block(nil, error);
        }
    } else {
        [self saveDataImage:data withKey:key];
        UIImage *image = [UIImage imageWithData:data];
        if (image) {
            [self.imageCache setObject:image forKey:key];
        }
        
        if (block) {
            block(image, nil);
        }
    }
}

/*
- (void)processSuccessfullLoageImage:(UIImage*)image withKey:(NSString*)key complete:(LoadImageBlock)complete {
    if (self.needCache) {
        [self.imageCache setObject:image forKey:key];
    }
    self.keyToMediaDownloader[key] = nil;
    [self.loadedKeys addObject:key];
    if (complete) {
        complete(YES, image, nil);
    }
}

- (void)processLoadImageWithError:(NSError*)error withKey:(NSString*)key complete:(LoadImageBlock)complete {
    self.keyToMediaDownloader[key] = nil;
    [self.erroredKeys addObject:key];
    if (complete) {
        complete(NO, nil, error);
    }
}
*/

@end
