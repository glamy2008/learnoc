//
//  NSObject+MTKeyboard.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "NSObject+MTKeyboard.h"
#import "UIView+MTView.h"
#import <objc/runtime.h>

static const void *keyboardResponseViewOriginalY = &keyboardResponseViewOriginalY;

@implementation NSObject (MTKeyboard)

- (NSNotification *)keyboardNotification {
    return objc_getAssociatedObject(self, @selector(keyboardNotification));
}

- (void)setKeyboardNotification:(NSNotification *)keyboardNotification {
    objc_setAssociatedObject(self, @selector(keyboardNotification), keyboardNotification, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)keyboardResponseView {
    return objc_getAssociatedObject(self, @selector(keyboardResponseView));
}

- (void)setKeyboardResponseView:(UIView *)keyboardResponseView {
    self.originalY = keyboardResponseView.view_y;
    objc_setAssociatedObject(self, @selector(keyboardResponseView), keyboardResponseView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)originalY {
    return [objc_getAssociatedObject(self, keyboardResponseViewOriginalY) floatValue];
}

- (void)setOriginalY:(CGFloat)originalY {
    objc_setAssociatedObject(self, keyboardResponseViewOriginalY, @(originalY), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isShowedKeyboard {
    if (self.keyboardNotification) {
        return YES;
    }
    return NO;
}

- (void)addKeyboardNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center  addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification  object:nil];
    [center  addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification  object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
}

- (void)removeKeyboardNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [center removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
    self.keyboardNotification = nil;
    self.keyboardResponseView = nil;
    self.originalY = 0;
}

- (CGSize)sizeKeyboard:(NSNotification *)notification {
    //获取键盘的size
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    return keyboardRect.size;
}

- (CGFloat)heightKeyboard:(NSNotification *)notification {
    //获取键盘的高度
    return [self sizeKeyboard:notification].height;
}

- (NSTimeInterval)durationKeyboardAnimation:(NSNotification *)notification {
    //获取键盘动画时间
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *aValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval duration = [aValue doubleValue];
    return duration;
}

- (void)keyboardWillShow:(NSNotification *)notification{
    self.keyboardNotification = notification;
    if (self.keyboardResponseView) {
        CGFloat newY = self.originalY - [self heightKeyboard:notification];
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:[self durationKeyboardAnimation:notification] animations:^{
            weakSelf.keyboardResponseView.view_y = newY;
        }];
    }
    
    if ([self respondsToSelector:@selector(keyboardWillShow)]) {
        [self keyboardWillShow];
    }
    
}

- (void)keyboardDidShow:(NSNotification *)notification{
    if ([self respondsToSelector:@selector(keyboardDidShow)]) {
        [self keyboardDidShow];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification{
    if (self.keyboardResponseView) {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:[self durationKeyboardAnimation:notification] animations:^{
            weakSelf.keyboardResponseView.view_y = weakSelf.originalY;
        }];
    }
    
    if ([self respondsToSelector:@selector(keyboardWillHide)]) {
        [self keyboardWillHide];
    }
}

- (void)keyboardDidHide:(NSNotification *)notification{
    self.keyboardNotification = nil;
    
    if ([self respondsToSelector:@selector(keyboardDidHide)]) {
        [self keyboardDidHide];
    }
}

@end
