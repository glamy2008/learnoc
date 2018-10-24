//
//  MTSwipePage.m
//  MTCompSwipeView
//
//  Created by Jason Li on 2018/3/16.
//

#import "MTSwipePage.h"

@import MJExtension;

@implementation MTSwipePage
+ (instancetype)initWithDict:(NSDictionary *)dict {
    return [MTSwipePage mj_objectWithKeyValues:dict];
}

- (NSURL *)pagePicURL {
    if (self.picURL.length == 0) return nil;
    return [NSURL URLWithString:self.picURL];
}

- (NSURL *)pageLandingURL {
    if (self.landingURL.length == 0) return nil;
    return [NSURL URLWithString:self.landingURL];
}

- (NSURLRequest *)requestPageLandingURl {
    if (![self pageLandingURL]) return nil;
    return [NSURLRequest requestWithURL:[self pageLandingURL]];
}

- (UIViewController<MTComponentProtocol> *)instanceLandingVC {
    if (self.landingVCName.length == 0) return nil;
    
    id comp = [[NSClassFromString(self.landingVCName) alloc] init];
    if ([comp isKindOfClass:[UITableViewController class]]) {
        comp = [[NSClassFromString(self.landingVCName) alloc] initWithStyle:self.style];
    }
    
    return comp;
}

@end
