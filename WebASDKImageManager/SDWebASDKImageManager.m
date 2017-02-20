// Copyright 2015-present James Ide. All rights reserved.

#import "SDWebASDKImageManager.h"

#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import "SDWebASDKImageContainer.h"

@implementation SDWebASDKImageManager

+ (instancetype)sharedManager
{
    static SDWebASDKImageManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SDWebImageManager *webImageManager = [SDWebImageManager sharedManager];
        instance = [[self alloc] initWithWebImageManager:webImageManager];
        instance.imageManagerOptions = 0;
        instance.webImageOptions = SDWebImageRetryFailed | SDWebImageContinueInBackground;
    });
    return instance;
}

- (instancetype)init
{
    return [self initWithWebImageManager:[SDWebImageManager sharedManager]];
}

- (instancetype)initWithWebImageManager:(SDWebImageManager *)manager
{
    if (self = [super init]) {
        _webImageManager = manager;
    }
    return self;
}

#pragma mark - ASImageCacheProtocol

- (void)cachedImageWithURL:(NSURL *)URL callbackQueue:(dispatch_queue_t)callbackQueue completion:(ASImageCacherCompletion)completion
{
    if (!URL) {
        completion(nil);
        return;
    }
    
    NSString *cacheKey = [self.webImageManager cacheKeyForURL:URL];
    [self.webImageManager.imageCache queryDiskCacheForKey:cacheKey done:^(UIImage *image, SDImageCacheType cacheType) {
        dispatch_async(callbackQueue ?: dispatch_get_main_queue(), ^{
            completion([SDWebASDKImageContainer containerForImage:image]);
        });
    }];
}

- (id<ASImageContainerProtocol>)synchronouslyFetchedCachedImageWithURL:(NSURL *)URL
{
    if (!URL) {
        return nil;
    }
    NSString* cacheKey = [self.webImageManager cacheKeyForURL:URL];
    return [SDWebASDKImageContainer containerForImage:[self.webImageManager.imageCache imageFromMemoryCacheForKey:cacheKey]];
}

- (void)clearFetchedImageFromCacheWithURL:(NSURL *)URL
{
    if ((self.imageManagerOptions & SDWebASDKImageManagerIgnoreClearMemory) || !URL) {
        return;
    }
    NSString* cacheKey = [self.webImageManager cacheKeyForURL:URL];
    [self.webImageManager.imageCache removeImageForKey:cacheKey fromDisk:NO withCompletion:nil];
}

#pragma mark - ASImageDownloaderProtocol

- (nullable id)downloadImageWithURL:(NSURL *)URL
                      callbackQueue:(dispatch_queue_t)callbackQueue
                   downloadProgress:(nullable ASImageDownloaderProgress)downloadProgressBlock
                         completion:(ASImageDownloaderCompletion)completion
{
    if (!URL) {
        NSString *domain = [NSBundle bundleForClass:[self class]].bundleIdentifier;
        NSString *description = @"The URL of the image to download is unspecified";
        completion(nil, [NSError errorWithDomain:domain code:0 userInfo:@{NSLocalizedDescriptionKey: description}], nil);
        return nil;
    }
    
    __weak id<SDWebImageOperation> weakOperation = nil;
    id<SDWebImageOperation> operation =  [self.webImageManager downloadImageWithURL:URL options:self.webImageOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
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
            completion([SDWebASDKImageContainer containerForImage:image], error, weakOperation);
        });
    }];
    weakOperation = operation;
    return operation;
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
