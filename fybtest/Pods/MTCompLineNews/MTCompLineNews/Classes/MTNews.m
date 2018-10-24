//
//  MTNews.m
//  MTCompLineNews
//
//  Created by Jason Li on 2018/4/11.
//

#import "MTNews.h"

@import MJExtension;

@implementation MTNews
+ (instancetype)initWithDict:(NSDictionary *)dict {
    return [MTNews mj_objectWithKeyValues:dict];
}
@end
