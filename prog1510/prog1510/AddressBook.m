//
//  AddressBook.m
//  prog1510
//
//  Created by neusoft on 2018/10/9.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#include "AddressBook.h"

@implementation AddressBook

@synthesize bookName, book;

-(instancetype) initWithName:(NSString *)name
{
    self = [super init];
    
    if(self) {
        bookName = [NSString stringWithString: name];
        book = [NSMutableArray array];
    }
    
    return self;
}

-(instancetype) init
{
    return [self initWithName: @"NoName"];
}

-(void)addCard:(AddressCard *)theCard
{
    [book addObject: theCard];
}

-(int) entries
{
    return [book count];
}

-(void) list
{
    NSLog(@"========== Contents of %@ ==========", bookName);
    
    for ( AddressCard *theCard in book) {
        NSLog(@"    %-20s      %-32s    ", [theCard.name UTF8String], [theCard.name UTF8String]);
    }
    
    NSLog(@"====================================");
}

@end
