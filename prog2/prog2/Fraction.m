//
//  Fraction.m
//  prog2
//
//  Created by neusoft on 2018/9/29.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#include "Fraction.h"

@implementation Fraction

@synthesize numerator, denominator;

-(void) print
{
    NSLog(@"%i/%i", numerator, denominator);
}

-(double) convertToNum
{
    if(denominator !=0 )
        return (double) numerator/denominator;
    else
        return NAN;
}

-(void) setTo:(int)n over:(int)d
{
    numerator = n;
    denominator = d;
}

-(void) add:(Fraction *)f
{
    numerator = numerator * f.denominator + f.numerator * denominator;
    denominator = denominator * f.denominator;
}

@end
