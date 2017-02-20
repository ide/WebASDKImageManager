//
//  SDWebASDKImageManagerOptions.h
//  WebASDKImageManager
//
//  Created by Scott Kensell on 2/20/17.
//  Copyright © 2017 James Ide. All rights reserved.
//

#ifndef SDWebASDKImageManagerOptions_h
#define SDWebASDKImageManagerOptions_h

typedef NS_OPTIONS(NSUInteger, SDWebASDKImageManagerOptions) {
    /**
     By default SDWebASDKImageManager implements the `clearFetchedImageFromCacheWithURL:` method from the
     ASImageCacheProtocol. This allows ASDK to optimize memory. If you do not want ASDK to remove any images
     from the memory cache then provide this option.
     */
    SDWebASDKImageManagerIgnoreClearMemory = 1 << 0,
};


#endif /* SDWebASDKImageManagerOptions_h */
