//
//  main.m
//  prog2
//
//  Created by neusoft on 2018/9/29.
//  Copyright © 2018年 neusoft. All rights reserved.
//
#include "Fraction.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Fraction *myFraction = [Fraction new];
        
        [myFraction setNumerator:3];
        [myFraction setDenominator:7];
        
        [myFraction print];
        
        NSLog(@"convertToNum = %f", [myFraction convertToNum]);
        
        [myFraction setTo: 5 over: 8];
        
        [myFraction print];
        
        Fraction *frac = [[Fraction alloc] init];
        [frac setTo:1 over:2];
        
        [myFraction add:frac];
        
        [myFraction print];
    }
    return 0;
}
