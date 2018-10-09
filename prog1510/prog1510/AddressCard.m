//
//  AddressCard.m
//  prog1510
//
//  Created by neusoft on 2018/10/9.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#include "AddressCard.h"

@implementation AddressCard

@synthesize name, email;

-(void) setName:(NSString *)theName andEmail:(NSString *)theEmail
{
    self.name = theName;
    self.email = theEmail;
}

-(void) print
{
    NSLog(@"=================================");
    NSLog(@"|                               |");
    NSLog(@"|    %-31s    |", [name UTF8String]);
    NSLog(@"|    %-31s    |", [email UTF8String]);
    NSLog(@"|                               |");
    NSLog(@"|                               |");
    NSLog(@"|                               |");
    NSLog(@"|     o            o            |");
    NSLog(@"=================================");
    
}

@end
