//
//  NSObject+MTLayout.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "NSObject+MTLayout.h"
#import <objc/runtime.h>
#import "UIDevice+MTDevice.h"

static const void *edgeInsetsTop = &edgeInsetsTop;
static const void *edgeInsetsLeft = &edgeInsetsLeft;
static const void *edgeInsetsBottom = &edgeInsetsBottom;
static const void *edgeInsetsRight = &edgeInsetsRight;

static const void *constRowHeight = &constRowHeight;
static const void *constNavHeight = &constNavHeight;

static const void *constStatusBarHeight = &constStatusBarHeight;
static const void *constTabBarHeight = &constTabBarHeight;

static const void *constControlInterval = &constControlInterval;

static const void *constCornerRadius = &constCornerRadius;

@implementation NSObject (MTLayout)

- (UIEdgeInsets)edgeInsets {
    CGFloat top = [objc_getAssociatedObject(self, edgeInsetsTop) floatValue];
    CGFloat left = [objc_getAssociatedObject(self, edgeInsetsBottom) floatValue];
    CGFloat bottom = [objc_getAssociatedObject(self, edgeInsetsBottom) floatValue];
    CGFloat right = [objc_getAssociatedObject(self, edgeInsetsRight) floatValue];
    return UIEdgeInsetsMake(top > 0.f ? top : 8.f, left > 0.f ? left : 15.f, bottom > 0.f ? bottom : 8.f, right > 0.f ? right : 15.f);
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    objc_setAssociatedObject(self, edgeInsetsTop, @(edgeInsets.top), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, edgeInsetsLeft, @(edgeInsets.left), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, edgeInsetsBottom, @(edgeInsets.bottom), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, edgeInsetsRight, @(edgeInsets.right), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)rowHeight {
    CGFloat height = [objc_getAssociatedObject(self, constRowHeight) floatValue];
    return height > 0.f ? height : 44.f;
}

- (void)setRowHeight:(CGFloat)rowHeight {
    objc_setAssociatedObject(self, constRowHeight, @(rowHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)navHeight {
    CGFloat height = [objc_getAssociatedObject(self, constNavHeight) floatValue];
    return height > 0.f ? height : (44.f + self.statusBarHeight);
}

- (void)setNavHeight:(CGFloat)navHeight {
    objc_setAssociatedObject(self, constNavHeight, @(navHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)statusBarHeight {
    CGFloat height = [objc_getAssociatedObject(self, constStatusBarHeight) floatValue];
    CGFloat defatul = 20.f;
    if ([UIDevice isIPHONEX]) {
        defatul = 44.f;
    }
    
    return height > 0.f ? height : defatul;
}

- (void)setStatusBarHeight:(CGFloat)statusBarHeight {
    objc_setAssociatedObject(self, constStatusBarHeight, @(statusBarHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)tabBarHeight {
    CGFloat height = [objc_getAssociatedObject(self, constTabBarHeight) floatValue];
    CGFloat defatul = 49.f;
    if ([UIDevice isIPHONEX]) {
        defatul = 83.f;
    }
    
    return height > 0.f ? height : defatul;
}

- (void)setTabBarHeight:(CGFloat)tabBarHeight {
    objc_setAssociatedObject(self, constTabBarHeight, @(tabBarHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)controlInterval {
    CGFloat interval = [objc_getAssociatedObject(self, constControlInterval) floatValue];
    CGFloat defatul = 10.f;
    
    return interval > 0.f ? interval : defatul;
}

- (void)setControlInterval:(CGFloat)controlInterval {
    objc_setAssociatedObject(self, constControlInterval, @(controlInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)controlHalfInterval {
    return self.controlInterval/2.0f;
}

- (CGFloat)cornerRadius {
    CGFloat radius = [objc_getAssociatedObject(self, constCornerRadius) floatValue];
    CGFloat defatul = 4.f;
    
    return radius > 0.f ? radius : defatul;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    objc_setAssociatedObject(self, constCornerRadius, @(cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
