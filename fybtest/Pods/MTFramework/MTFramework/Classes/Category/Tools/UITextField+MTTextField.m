//
//  UITextField+MTTextField.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "UITextField+MTTextField.h"
#import <objc/runtime.h>
#import "NSString+MTString.h"
#import "NSObject+MTLayout.h"

@import JRSwizzle;

static const void *textFieldMenuUnvisible = &textFieldMenuUnvisible;

@implementation UITextField (MTTextField)
- (BOOL)menuUnvisible {
    return [objc_getAssociatedObject(self, textFieldMenuUnvisible) boolValue];
}

- (void)setMenuUnvisible:(BOOL)menuUnvisible {
    objc_setAssociatedObject(self, textFieldMenuUnvisible, @(menuUnvisible), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (void)setPlaceholderColor:(UIColor *)color {
    if (self.placeholder.length > 0) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:color}];
    }
    
}

- (NSMutableAttributedString *)attributedString {
    NSMutableAttributedString *string = nil;
    if (self.attributedText) {
        string = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    } else {
        string = [[NSMutableAttributedString alloc] initWithString:self.text];
        [string addAttribute:NSFontAttributeName value:self.font range:[self.text range]];
        [string addAttribute:NSForegroundColorAttributeName value:self.textColor range:[self.text range]];
        [string addAttribute:NSBackgroundColorAttributeName value:self.backgroundColor range:[self.text range]];
        
    }
    
    return string;
}

- (void)addAttributeFont:(id)font ragne:(NSRange)range {
    NSMutableAttributedString *string = [self attributedString];
    [string removeAttribute:NSFontAttributeName range:range];
    [string addAttribute:NSFontAttributeName value:font range:range];
    
    [self setAttributedText:string];
}

- (void)addAttributeColor:(id)color ragne:(NSRange)range {
    NSMutableAttributedString *string = [self attributedString];
    [string removeAttribute:NSForegroundColorAttributeName range:range];
    [string addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    [self setAttributedText:string];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        BOOL result = [[self class] jr_swizzleMethod:@selector(canPerformAction:withSender:) withMethod:@selector(mt_canPerformAction:withSender:) error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
        
        result = [[self class] jr_swizzleMethod:@selector(leftViewRectForBounds:) withMethod:@selector(mt_leftViewRectForBounds:) error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
        
        result = [[self class] jr_swizzleMethod:@selector(rightViewRectForBounds:) withMethod:@selector(mt_rightViewRectForBounds:) error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
        
        result = [[self class] jr_swizzleMethod:@selector(textRectForBounds:) withMethod:@selector(mt_textRectForBounds:) error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
        
        result = [[self class] jr_swizzleMethod:@selector(placeholderRectForBounds:) withMethod:@selector(mt_placeholderRectForBounds:) error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
        
        result = [[self class] jr_swizzleMethod:@selector(editingRectForBounds:) withMethod:@selector(mt_editingRectForBounds:) error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
    });
}

- (BOOL)mt_canPerformAction:(SEL)action withSender:(id)sender {
    if (self.menuUnvisible) {
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        if (menuController) {
            [UIMenuController sharedMenuController].menuVisible = NO;
        }
        
        return NO;
    }
    
    return [self mt_canPerformAction:action withSender:sender];
}

- (CGRect)mt_leftViewRectForBounds:(CGRect)bounds {
    bounds.size.height = CGRectGetHeight(self.bounds);
    bounds.size.width = CGRectGetHeight(self.bounds);
    return bounds;
}

- (CGRect)mt_rightViewRectForBounds:(CGRect)bounds {
    bounds.size.height = CGRectGetHeight(self.bounds);
    bounds.size.width = CGRectGetHeight(self.bounds);
    bounds.origin.x = CGRectGetWidth(self.bounds) - CGRectGetWidth(bounds);
    
    return bounds;
}

- (CGRect)mt_textRectForBounds:(CGRect)bounds {
    if (self.layer.borderWidth > 0.0f && !self.leftView) {
        bounds.origin.x += self.edgeInsets.left;
    } else if (self.leftView && self.textAlignment != NSTextAlignmentRight) {
        bounds.origin.x += CGRectGetMaxX(self.leftView.frame);
    }
    return bounds;
}

- (CGRect)mt_placeholderRectForBounds:(CGRect)bounds {
    if (self.layer.borderWidth > 0.0f && !self.leftView) {
        bounds.origin.x += self.edgeInsets.left;
    } else if (self.leftView && self.textAlignment != NSTextAlignmentRight) {
        bounds.origin.x += CGRectGetMaxX(self.leftView.frame);
    }
    return bounds;
}

- (CGRect)mt_editingRectForBounds:(CGRect)bounds {
    if (self.layer.borderWidth > 0.0f && !self.leftView) {
        bounds.origin.x += self.edgeInsets.left;
    } else if (self.leftView && self.textAlignment != NSTextAlignmentRight) {
        bounds.origin.x += CGRectGetMaxX(self.leftView.frame);
    }
    return bounds;
}

@end
