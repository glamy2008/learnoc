//
//  UIDevice+MTDevice.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import <UIKit/UIKit.h>

@interface UIDevice (MTDevice)
+ (BOOL)currentSystemVersionLessThan:(CGFloat)targetVersion;

+ (NSString *)deviceModelName;

+ (BOOL)isIPHONEX;

@end
