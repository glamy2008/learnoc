//
//  UIViewController+MTInit.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "UIViewController+MTInit.h"
#import "MTViewProtocol.h"

@import JRSwizzle;

@implementation UIViewController (MTInit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        BOOL result = result = [[self class] jr_swizzleMethod:@selector(viewWillLayoutSubviews) withMethod:@selector(jl_viewWillLayoutSubviews) error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
    });
}

- (void)jl_viewWillLayoutSubviews {
    [self jl_viewWillLayoutSubviews];
    
    if ([self respondsToSelector:@selector(setupLayoutConstraint)]) {
        [self setupLayoutConstraint];
    }
}

@end
