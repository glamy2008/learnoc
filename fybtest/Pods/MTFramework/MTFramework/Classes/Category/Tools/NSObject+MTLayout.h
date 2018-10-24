//
//  NSObject+MTLayout.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import <Foundation/Foundation.h>

@interface NSObject (MTLayout)
@property (nonatomic) UIEdgeInsets edgeInsets; // Default 8.f,15.f,8.f,15.f

@property (nonatomic) CGFloat rowHeight; // Default 44.f

@property (nonatomic) CGFloat navHeight; // Default 64.f , 88.f when iPhoneX
@property (nonatomic) CGFloat statusBarHeight; // Default 20.f , 44.f When iPhoneX
@property (nonatomic) CGFloat tabBarHeight; // Default 49.f, 83.f When iPhoneX

@property (nonatomic) CGFloat controlInterval; // Default 10.f
- (CGFloat)controlHalfInterval; // Default 5.f

@property (nonatomic) CGFloat cornerRadius; // Default 4.f
@end
