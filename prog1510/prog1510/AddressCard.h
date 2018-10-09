//
//  AdressCard.h
//  prog1510
//
//  Created by neusoft on 2018/10/9.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#ifndef AddressCard_h
#define AddressCard_h

#import <foundation/foundation.h>

@interface AddressCard : NSObject

@property (copy, nonatomic) NSString *name, *email;

-(void) setName: (NSString *) theName andEmail: (NSString *) theEmail;

-(void) print;

@end

#endif /* AdressCard_h */
