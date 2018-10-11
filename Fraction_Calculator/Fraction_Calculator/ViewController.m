//
//  ViewController.m
//  Fraction_Calculator
//
//  Created by neusoft on 2018/10/11.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    char                op;
    int                 currentNumber;
    BOOL                firstOperand, isNumberator;
    Calculator          *myCalculator;
    NSMutableString     *displayString;
}

@synthesize display;

- (void)viewDidLoad {
    [super viewDidLoad];
    firstOperand = YES;
    isNumberator = YES;
    
}


@end
