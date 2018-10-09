//
//  main.m
//  prog1510
//
//  Created by neusoft on 2018/10/9.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#include "AddressCard.h"
#include "AddressBook.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSString *aName = @"Jason Kwan";
        NSString *aEmail = @"jason@hotmail.com";
        NSString *bName = @"Silen Kwan";
        NSString *bEmail = @"silen@hotmail.com";
        NSString *cName = @"Crystal Chen";
        NSString *cEmail = @"crystal@hotmail.com";
        
        AddressCard *card1 = [[AddressCard alloc] init];
        AddressCard *card2 = [[AddressCard alloc] init];
        AddressCard *card3 = [[AddressCard alloc] init];
        
        [card1 setName: aName andEmail: aEmail];
        [card2 setName: bName andEmail: bEmail];
        [card3 setName: cName andEmail: cEmail];
        
        AddressBook *book = [[AddressBook alloc] initWithName:@"MyBook"];
        [book addCard: card1];
        [book addCard: card2];
        [book addCard: card3];
        
        NSLog(@"begin sort ==============");
        
        [book sort];
        
        NSLog(@"end sort ================");
        
        NSLog(@"%i of entries in %@", [book entries], [book bookName]);
        
        [book list];
        
        
    }
    return 0;
}
