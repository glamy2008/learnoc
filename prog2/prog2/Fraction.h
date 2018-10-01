//
//  Fraction.h
//  prog2
//
//  Created by neusoft on 2018/9/29.
//  Copyright © 2018年 neusoft. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef Fraction_h
#define Fraction_h

@interface Fraction : NSObject

@property int numerator, denominator;

-(void)  print;
-(double) convertToNum;
-(void) setTo: (int) n over: (int) d;
-(void) add:(Fraction *) f;

@end


#endif /* Fraction_h */
