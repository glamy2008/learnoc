//
//  main.m
//  prog1
//
//  Created by neusoft on 2018/9/27.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//-----@interface部分--------
@interface Fraction: NSObject

-(void)  print;
-(void)  setNumerator: (int) n;
-(void)  setDenominator: (int) d;
@end

//----@implementation部分----------
@implementation Fraction
{
    int Numeractor;
    int Denominator;
}

-(void) print
{
    NSLog(@"%i/%i", Numeractor, Denominator);
}

-(void) setNumerator:(int)n
{
    Numeractor = n;
}

-(void) setDenominator:(int)d
{
    Denominator = d;
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //Fraction *myFraction;
        
        //myFraction = [Fraction alloc];
        //myFraction = [myFraction init];
        
        Fraction *frac1 = [[Fraction alloc] init];
        Fraction *frac2 = [[Fraction alloc] init];
        
        [frac1 setNumerator: 1];
        [frac1 setDenominator: 3];
        
        [frac2 setNumerator: 3];
        [frac2 setDenominator: 7];
        
        NSLog(@"The first of Fraction is:");
        [frac1 print];
        NSLog(@"The second of Fraction is:");
        [frac2 print];
    }
    return 0;
}
