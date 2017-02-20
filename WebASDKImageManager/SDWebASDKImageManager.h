// Copyright 2015-present James Ide. All rights reserved.

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import <SDWebImage/SDWebImageManager.h>
#import "SDWebASDKImageManagerOptions.h"

@interface SDWebASDKImageManager : NSObject <ASImageCacheProtocol, ASImageDownloaderProtocol>

@property (nonatomic, assign) SDWebImageOptions webImageOptions;
@property (nonatomic, strong, readonly) SDWebImageManager *webImageManager;
@property (nonatomic, assign) SDWebASDKImageManagerOptions imageManagerOptions;

+ (instancetype)sharedManager;

- (instancetype)initWithWebImageManager:(SDWebImageManager *)manager NS_DESIGNATED_INITIALIZER;

@end
