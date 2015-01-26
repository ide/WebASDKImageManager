# WebASDKImageManager

[![Version](https://img.shields.io/cocoapods/v/WebASDKImageManager.svg?style=flat)](http://cocoadocs.org/docsets/WebASDKImageManager)
[![License](https://img.shields.io/cocoapods/l/WebASDKImageManager.svg?style=flat)](http://cocoadocs.org/docsets/WebASDKImageManager)
[![Platform](https://img.shields.io/cocoapods/p/WebASDKImageManager.svg?style=flat)](http://cocoadocs.org/docsets/WebASDKImageManager)

An image downloader and cache for AsyncDisplayKit that uses SDWebImage. This is an implementation of `ASImageDownloaderProtocol` and `ASImageCacheProtocol` that is compatible with `ASNetworkImageNode`.

By default, `ASNetworkImageNode` does not cache images and does not coalesce network requests for the same image. SDWebImage does both of these. With WebASDKImageManager, you get the image downloading and caching optimizations of SDWebImage and the asynchronous layout and layer precompositing features of ASDK.

# Installation

WebASDKImageManager is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "WebASDKImageManager"
```

# Usage

The easiest way to use WebASDKImageManager is an initializer is provides in a category on `ASNetworkImageNode`.

```objc
ASNetworkImageNode *imageNode = [[ASNetworkImageNode alloc] initWithWebImage];
imageNode.URL = imageURL;
```
