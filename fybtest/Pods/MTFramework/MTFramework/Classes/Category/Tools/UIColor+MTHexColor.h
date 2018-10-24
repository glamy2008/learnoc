//
//  UIColor+MTHexColor.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import <UIKit/UIKit.h>

@interface UIColor (MTHexColor)
+ (instancetype)colorWithHex:(NSString *)hex;
+ (instancetype)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;

+ (NSString *)hexFromColor:(UIColor *)color;

@end
