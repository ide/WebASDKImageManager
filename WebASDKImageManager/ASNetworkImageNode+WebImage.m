// Copyright 2015-present James Ide. All rights reserved.

#import "ASNetworkImageNode+WebImage.h"

#import "SDWebASDKImageManager.h"

@implementation ASNetworkImageNode (WebImage)

- (instancetype)initWithWebImage
{
    SDWebASDKImageManager *imageManager = [SDWebASDKImageManager sharedManager];
    return [self initWithCache:imageManager downloader:imageManager];
}

@end
