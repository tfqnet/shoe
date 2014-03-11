

#import <Foundation/Foundation.h>
#import "SDWebImageManagerDelegate.h"
@interface UIButton (WebCache) <SDWebImageManagerDelegate>

- (void)setImageWithURL:(NSURL *)url;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)cancelCurrentImageLoad;

@end
