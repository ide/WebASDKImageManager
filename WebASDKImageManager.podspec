Pod::Spec.new do |s|
  s.name             = "WebASDKImageManager"
  s.version          = "2.0.0"
  s.summary          = "Image downloader and cache for AsyncDisplayKit that uses SDWebImage"
  s.description      = <<-DESC
    An image downloader and cache for AsyncDisplayKit that uses SDWebImage. The image manager conforms to ASImageDownloaderProtocol and ASImageCacheProtocol.
                       DESC
  s.homepage         = "https://github.com/ide/WebASDKImageManager"
  s.license          = 'MIT'
  s.author           = "James Ide"
  s.source           = { :git => "https://github.com/ide/WebASDKImageManager.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = [
    'WebASDKImageManager/*.{h,m}'
  ]
  s.dependency 'AsyncDisplayKit/Core', '~> 2.0'
  s.dependency 'SDWebImage/Core', '~> 4.0'
end
