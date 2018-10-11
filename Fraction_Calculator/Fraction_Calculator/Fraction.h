//
//  Fraction.h
//  Fraction_Calculator
//
//  Created by neusoft on 2018/10/11.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Fraction : NSObject

@property int numerator, denominator;

-(void)             print;
-(void)             setTo: (int) n over: (int) d;
-(Fraction *)       add: (Fraction *) f;
-(Fraction *)       subtract: (Fraction *) f;
-(Fraction *)       multiply: (Fraction *) f;
-(Fraction *)       divide: (Fraction *) f;
-(void)             reduce;
-(double)           convertToNum;
-(NSString *)       convertToString;

@end

NS_ASSUME_NONNULL_END
