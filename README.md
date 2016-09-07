# WebASDKImageManager

[![Version](https://img.shields.io/cocoapods/v/WebASDKImageManager.svg?style=flat)](http://cocoadocs.org/docsets/WebASDKImageManager)
[![License](https://img.shields.io/cocoapods/l/WebASDKImageManager.svg?style=flat)](http://cocoadocs.org/docsets/WebASDKImageManager)
[![Platform](https://img.shields.io/cocoapods/p/WebASDKImageManager.svg?style=flat)](http://cocoadocs.org/docsets/WebASDKImageManager)

# Notice

[AsyncDisplayKit](https://github.com/facebook/AsyncDisplayKit) now uses Pinterest's PINRemoteImage and PINCache if you include them as dependencies. They provide the functionality that WebASDKImageManager originally set to provide and manage memory more efficiently because they work more tightly with AsyncDisplayKit. Unless you specifically wish to use SDWebImage, you should use AsyncDisplayKit's default functionality.

---

An image downloader and cache for [AsyncDisplayKit](https://github.com/facebook/AsyncDisplayKit) that uses [SDWebImage](https://github.com/rs/SDWebImage). This is an implementation of `ASImageDownloaderProtocol` and `ASImageCacheProtocol` that is compatible with `ASNetworkImageNode`.

By default, `ASNetworkImageNode` does not cache images and does not coalesce network requests for the same image. SDWebImage does both of these. With WebASDKImageManager, you get the image downloading and caching optimizations of SDWebImage and the asynchronous layout and layer precompositing features of ASDK.

# Installation

WebASDKImageManager is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "WebASDKImageManager"
```

# Usage

The easiest way to use WebASDKImageManager is an initializer it provides in a category on `ASNetworkImageNode`.

```objc
ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] initWithWebImage];
// Setting the URL property will automatically access the memory and disk
// caches, and download and cache the image if necessary
imageNode.URL = imageURL;
```

## Configuration

By default, image downloading and caching is handled by a shared `WebASDKImageManager` instance. You can get a reference to the shared manager by calling `[SDWebASDKImageManager sharedManager]`. Its `webImageOptions` property is the way to configure the downloading and caching behavior for all ASNetworkImageNode instances that used the shared manager.

```objc
SDWebASDKImageManager *defaultManager = [SDWebASDKImageManager sharedManager];
// No longer try to download images that were previously unavailable
defaultManager.webImageOptions &= ~SDWebImageRetryFailed;
```

### Defaults

The default options are `SDWebImageRetryFailed` and `SDWebImageContinueInBackground`, which are generally what you want. See SDWebImage's `SDWebImageOptions` enum for all of the supported options.

### Configuring a Single Image Node

Sometimes you may want to configure an image node differently than the default. You can do this by creating a new `WebASDKImageManager` that is configured to meet your needs.

```objc
SDWebImageManager *webImageManager = [SDWebImageManager sharedManager];
SDWebASDKImageManager *asyncImageManager =
  [[SDWebASDKImageManager alloc] initWithWebImageManager:webImageManager];
asyncImageManager.webImageOptions = SDWebImageRetryFailed | SDWebImageCacheMemoryOnly;
```

`WebASDKImageManager` conforms to `ASImageDownloaderProtocol` and `ASImageCacheProtocol`, so you can use your new manager to create a new image node.

```objc
ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] initWithCache:asyncImageManager 
                                                               downloader:asyncImageManager];
```
