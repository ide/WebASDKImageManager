//
//  SDWebASDKImageContainer.m
//  WebASDKImageManager
//
//  Created by Scott Kensell on 2/20/17.
//  Copyright © 2017 James Ide. All rights reserved.
//

#import "SDWebASDKImageContainer.h"

@implementation SDWebASDKImageContainer

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

+ (instancetype)containerForImage:(UIImage *)image {
    return [[self alloc] initWithImage:image];
}

#pragma mark - ASImageContainerProtocol

- (nullable UIImage *)asdk_image {
    return _image;
}

- (NSData *)asdk_animatedImageData {
    return nil;
}

@end
