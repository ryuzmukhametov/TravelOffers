//
//  ImageLoader.h
//  TravelOffers
//
//  Created by Rustam Yuzmukhametov on 16/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^LoadImageCompletionBlock)(UIImage *image, NSError *error);

@protocol ImageLoader <NSObject>

- (void)loadImageByURL:(NSURL*)URL complete:(LoadImageCompletionBlock)block;
- (UIImage*)loadedImageByURL:(NSURL*)URL;

@end
