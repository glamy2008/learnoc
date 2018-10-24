//
//  UITableViewCell+MTInit.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "UITableViewCell+MTInit.h"
#import "MTViewProtocol.h"

@import JRSwizzle;

@implementation UITableViewCell (MTInit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        BOOL result = [[self class] jr_swizzleMethod:@selector(initWithStyle:reuseIdentifier:) withMethod:@selector(jl_initWithStyle:reuseIdentifier:) error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
    });
}

- (instancetype)jl_initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    id obj = [self jl_initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (obj) {
        if ([obj respondsToSelector:@selector(initCell)]) {
            [obj initCell];
        }
    }
    return obj;
}

@end
