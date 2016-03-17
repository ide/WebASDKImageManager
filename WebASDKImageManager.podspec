Pod::Spec.new do |s|
  s.name             = "WebASDKImageManager"
  s.version          = "1.1.0"
  s.summary          = "Image downloader and cache for AsyncDisplayKit that uses SDWebImage"
  s.description      = <<-DESC
    An image downloader and cache for AsyncDisplayKit that uses SDWebImage. The image manager conforms to ASImageDownloaderProtocol and ASImageCacheProtocol.
                       DESC
  s.homepage         = "https://github.com/ide/WebASDKImageManager"
  s.license          = 'MIT'
  s.author           = "James Ide"
  s.source           = { :git => "https://github.com/ide/WebASDKImageManager.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = [
    'WebASDKImageManager/*.{h,m}'
  ]
  s.dependency 'AsyncDisplayKit', '~> 1.9'
  s.dependency 'SDWebImage/Core', '~> 3.7'
end
