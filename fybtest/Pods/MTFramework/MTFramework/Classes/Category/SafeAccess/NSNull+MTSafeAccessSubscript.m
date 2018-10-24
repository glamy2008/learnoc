//
//  NSNull+MTSafeAccessSubscript.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "NSNull+MTSafeAccessSubscript.h"

@implementation NSNull (MTSafeAccessSubscript)
- (id)objectForKeyedSubscript:(id)key {
    return nil;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return nil;
}
@end
