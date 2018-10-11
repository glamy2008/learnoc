//
//  ViewController.m
//  iphone1
//
//  Created by neusoft on 2018/10/11.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize display;

-(IBAction) click1
{
    display.text = @"1";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
