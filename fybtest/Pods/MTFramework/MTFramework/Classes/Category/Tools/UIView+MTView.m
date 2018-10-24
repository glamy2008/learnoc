//
//  UIView+MTView.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "UIView+MTView.h"
#import <objc/runtime.h>

static const void *contentInsetsTop = &contentInsetsTop;
static const void *contentInsetsLeft = &contentInsetsLeft;
static const void *contentInsetsBottom = &contentInsetsBottom;
static const void *contentInsetsRight = &contentInsetsRight;

@implementation UIView (JLViewFrame)

- (UIEdgeInsets)contentInsets {
    CGFloat top = [objc_getAssociatedObject(self, contentInsetsTop) floatValue];
    CGFloat left = [objc_getAssociatedObject(self, contentInsetsLeft) floatValue];
    CGFloat bottom = [objc_getAssociatedObject(self, contentInsetsBottom) floatValue];
    CGFloat right = [objc_getAssociatedObject(self, contentInsetsRight) floatValue];
    return UIEdgeInsetsMake(top, left, bottom, right);
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    objc_setAssociatedObject(self, contentInsetsTop, @(contentInsets.top), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, contentInsetsLeft, @(contentInsets.left), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, contentInsetsBottom, @(contentInsets.bottom), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, contentInsetsRight, @(contentInsets.right), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if ([self respondsToSelector:@selector(viewDidChangedContentInsets)]) {
        [self viewDidChangedContentInsets];
    }
}

- (CGFloat)view_x {
    return self.frame.origin.x;
}

- (void)setView_x:(CGFloat)view_x {
    CGRect rect = self.frame;
    rect.origin.x = view_x;
    self.frame = rect;
}

- (CGFloat)view_y {
    return self.frame.origin.y;
}

- (void)setView_y:(CGFloat)view_y {
    CGRect rect = self.frame;
    rect.origin.y = view_y;
    self.frame = rect;
}

- (CGFloat)view_width {
    return self.frame.size.width;
}

- (void)setView_width:(CGFloat)view_width {
    CGRect rect = self.frame;
    rect.size.width = view_width;
    self.frame = rect;
}

- (CGFloat)view_height {
    return self.frame.size.height;
}

- (void)setView_height:(CGFloat)view_height {
    CGRect rect = self.frame;
    rect.size.height = view_height;
    self.frame = rect;
}

- (CGSize)view_size {
    return self.frame.size;
}

- (void)setView_size:(CGSize)view_size {
    CGRect rect = self.frame;
    rect.size = view_size;
    self.frame = rect;
}

- (CGPoint)view_origin {
    return self.frame.origin;
}

- (void)setView_origin:(CGPoint)view_origin {
    CGRect rect = self.frame;
    rect.origin = view_origin;
    self.frame = rect;
}

- (CGSize)contentSize {
    return [self contentSizeInView:self];
}

- (CGSize)contentSizeInView:(UIView *)view {
    return [self contentSizeInView:view atInsets:view.contentInsets];
}

- (CGSize)contentSizeInView:(UIView *)view atInsets:(UIEdgeInsets)inset {
    return CGSizeMake(CGRectGetWidth(view.bounds) - inset.left - inset.right, CGFLOAT_MAX);
}

@end
