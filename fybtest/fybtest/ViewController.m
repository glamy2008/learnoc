//
//  ViewController.m
//  fybtest
//
//  Created by neusoft on 2018/10/18.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#import "ViewController.h"
#import "GGTabBarController.h"

@interface ViewController ()

@property (nonatomic, strong) GGTabBarController *tabBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addChildViewController: self.tabBar];
}


@end
