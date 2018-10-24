//
//  UIView+MTInit.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "UIView+MTInit.h"
#import "MTViewProtocol.h"

@import JRSwizzle;

@implementation UIView (MTInit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        BOOL result = [[self class] jr_swizzleMethod:@selector(initWithCoder:) withMethod:@selector(jl_initWithCoder:) error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
        
        result = [[self class] jr_swizzleMethod:@selector(initWithFrame:) withMethod:@selector(jl_initWithFrame:) error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
        
        result = [[self class] jr_swizzleMethod:@selector(layoutSubviews) withMethod:@selector(jl_layoutSubviews) error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
    });
}

- (instancetype)jl_initWithCoder:(NSCoder *)aDecoder {
    id obj = [self jl_initWithCoder:aDecoder];
    if (self) {
        if ([obj respondsToSelector:@selector(initView)]) {
            [obj initView];
        }
    }
    return obj;
}

- (instancetype)jl_initWithFrame:(CGRect)frame {
    id obj = [self jl_initWithFrame:frame];
    if (self) {
        if ([obj respondsToSelector:@selector(initView)]) {
            [obj initView];
        }
    }
    return obj;
}

- (void)jl_layoutSubviews {
    [self jl_layoutSubviews];
    
    if ([self respondsToSelector:@selector(setupLayoutConstraint)]) {
        [self setupLayoutConstraint];
    }
}

@end
