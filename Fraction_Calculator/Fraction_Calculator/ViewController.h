//
//  ViewController.h
//  Fraction_Calculator
//
//  Created by neusoft on 2018/10/11.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *display;

-(void) processDigit: (int) digit;
-(void) processOp: (char) theOp;
-(void) storeFracPart;

-(IBAction) clickDigit: (UIButton *) sender;

-(IBAction) clickPlus;
-(IBAction) clickMinus;
-(IBAction) clickMultiply;
-(IBAction) clickDivide;

-(IBAction) clickClear;
-(IBAction) clickOver;
-(IBAction) clickEquals;

@end

