//
//  NSObject+MTUserDefault.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "NSObject+MTUserDefault.h"

@implementation NSObject (MTUserDefault)
- (void)setUserDefaultObject:(id)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)userDefaultObjectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
