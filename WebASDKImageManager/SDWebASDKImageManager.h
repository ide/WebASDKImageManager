// Copyright 2015-present James Ide. All rights reserved.

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import <SDWebImage/SDWebImageManager.h>

@interface SDWebASDKImageManager : NSObject <ASImageCacheProtocol, ASImageDownloaderProtocol>

@property (nonatomic) SDWebImageOptions webImageOptions;
@property (nonatomic, strong, readonly) SDWebImageManager *webImageManager;

+ (instancetype)sharedManager;

- (instancetype)initWithWebImageManager:(SDWebImageManager *)manager NS_DESIGNATED_INITIALIZER;

@end
