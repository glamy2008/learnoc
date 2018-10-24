//
//  UIImage+MTImageTint.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "UIImage+MTImageTint.h"

@implementation UIImage (MTImageTint)
+ (instancetype)imageNamed:(NSString *)name tintColor:(UIColor *)tintColor {
    UIImage *image = [UIImage imageNamed:name];
    if (tintColor) {
        return [image imageWithTintColor:tintColor];
    }
    return image;
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor {
    return [self imageWithTintColor:tintColor blendModel:kCGBlendModeDestinationIn alpha:1.0f];
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor alpha:(CGFloat)alpha {
    return [self imageWithTintColor:tintColor blendModel:kCGBlendModeDestinationIn alpha:alpha];
}

- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendModel:(CGBlendMode)blendMode alpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:alpha];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
