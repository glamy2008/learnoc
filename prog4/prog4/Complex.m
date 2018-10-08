//
//  Complex.m
//  prog4
//
//  Created by crystal on 2018/10/2.
//  Copyright © 2018年 crystal. All rights reserved.
//

#include "Complex.h"

@implementation Complex

@synthesize real, imaginary;

-(void) print
{
    NSLog(@"%g + %g", real, imaginary);
}

-(void) setReal:(double)a andImaginary:(double)b
{
    real = a;
    imaginary = b;
}

-(Complex *) add:(Complex *)f
{
    Complex *result = [[Complex alloc] init];
    
    result.real = real + f.real;
    result.imaginary = imaginary + f.imaginary;
    
    return result;
}


@end
