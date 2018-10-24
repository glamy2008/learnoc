//
//  NSObject+MTUserDefault.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import <Foundation/Foundation.h>

@interface NSObject (MTUserDefault)
- (void)setUserDefaultObject:(id)value forKey:(NSString *)key;
- (id)userDefaultObjectForKey:(NSString *)key;

@end
