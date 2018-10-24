//
//  MTSafeAccessSubscriptProtocol.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import <Foundation/Foundation.h>

@protocol MTSafeAccessSubscriptProtocol <NSObject>
@required
- (id)objectForKeyedSubscript:(id)key;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

@optional
- (void)setObject:(id)object forKeyedSubscript:(id < NSCopying >)aKey;
- (void)setObject:(id)anObject atIndexedSubscript:(NSUInteger)index;

@end
