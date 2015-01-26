# WebASDKImageManager
An image downloader and cache for AsyncDisplayKit that uses SDWebImage. You can use it with `ASNetworkImageNode`.

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
