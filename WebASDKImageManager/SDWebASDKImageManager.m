// Copyright 2015-present James Ide. All rights reserved.

#import "SDWebASDKImageManager.h"

#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>

@implementation SDWebASDKImageManager

+ (instancetype)sharedManager
{
    static SDWebASDKImageManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SDWebImageManager *webImageManager = [SDWebImageManager sharedManager];
        instance = [[self alloc] initWithWebImageManager:webImageManager];
        instance.webImageOptions = SDWebImageRetryFailed | SDWebImageContinueInBackground;
    });
    return instance;
}

- (instancetype)initWithWebImageManager:(SDWebImageManager *)manager
{
    if (self = [super init]) {
        _webImageManager = manager;
    }
    return self;
}

#pragma mark - ASImageCacheProtocol

- (void)fetchCachedImageWithURL:(NSURL *)URL callbackQueue:(dispatch_queue_t)callbackQueue completion:(void (^)(CGImageRef imageFromCache))completion
{
    if (!URL) {
        completion(nil);
        return;
    }

    NSString *cacheKey = [self.webImageManager cacheKeyForURL:URL];
    [self.webImageManager.imageCache queryDiskCacheForKey:cacheKey done:^(UIImage *image, SDImageCacheType cacheType) {
        dispatch_async(callbackQueue ?: dispatch_get_main_queue(), ^{
            completion(image.CGImage);
        });
    }];
}

#pragma mark - ASImageDownloaderProtocol

- (id)downloadImageWithURL:(NSURL *)URL callbackQueue:(dispatch_queue_t)callbackQueue downloadProgressBlock:(void (^)(CGFloat progress))downloadProgressBlock completion:(void (^)(CGImageRef image, NSError *error))completion
{
    if (!URL) {
        NSString *domain = [NSBundle bundleForClass:[self class]].bundleIdentifier;
        NSString *description = @"The URL of the image to download is unspecified";
        completion(nil, [NSError errorWithDomain:domain code:0 userInfo:@{NSLocalizedDescriptionKey: description}]);
        return nil;
    }

    return [self.webImageManager downloadImageWithURL:URL options:self.webImageOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (downloadProgressBlock) {
            dispatch_async(callbackQueue ?: dispatch_get_main_queue(), ^{
                downloadProgressBlock((CGFloat)receivedSize / expectedSize);
            });
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (!finished) {
            return;
        }

        dispatch_async(callbackQueue ?: dispatch_get_main_queue(), ^{
            completion(image.CGImage, error);
        });
    }];
}

- (void)cancelImageDownloadForIdentifier:(id)downloadIdentifier
{
    if (!downloadIdentifier) {
        return;
    }

    NSAssert([[downloadIdentifier class] conformsToProtocol:@protocol(SDWebImageOperation)], @"Unexpected image download identifier");
    id<SDWebImageOperation> downloadOperation = downloadIdentifier;
    [downloadOperation cancel];
}

@end
