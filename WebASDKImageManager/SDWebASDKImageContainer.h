//
//  SDWebASDKImageContainer.h
//  WebASDKImageManager
//
//  Created by Scott Kensell on 2/20/17.
//  Copyright © 2017 James Ide. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface SDWebASDKImageContainer : NSObject <ASImageContainerProtocol>

@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithImage:(UIImage *)image;
+ (instancetype)containerForImage:(UIImage *)image;

@end
