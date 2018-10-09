//
//  AddressBook.h
//  prog1510
//
//  Created by neusoft on 2018/10/9.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#ifndef AddressBook_h
#define AddressBook_h

#import <foundation/foundation.h>
#include "AddressCard.h"

@interface AddressBook : NSObject

@property (nonatomic, copy) NSString *bookName;
@property (nonatomic, strong) NSMutableArray *book;

-(instancetype) initWithName: (NSString *) name;
-(void) addCard: (AddressCard *) theCard;
-(int) entries;
-(void) list;
-(void) sort;
@end


#endif /* AddressBook_h */
