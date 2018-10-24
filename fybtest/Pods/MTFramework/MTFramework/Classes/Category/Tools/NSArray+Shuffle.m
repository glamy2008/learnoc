//
//  NSArray+Shuffle.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "NSArray+Shuffle.h"

@implementation NSArray (Shuffle)
- (NSArray *)shuffle {
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return (arc4random() % 3) - 1;
    }];
}

@end
