//
//  Complex.h
//  prog4
//
//  Created by crystal on 2018/10/2.
//  Copyright © 2018年 crystal. All rights reserved.
//

#ifndef Complex_h
#define Complex_h

#import <Foundation/Foundation.h>

@interface Complex : NSObject

@property double real, imaginary;

-(void) print;
-(void) setReal: (double) a andImaginary: (double) b;
-(Complex *) add: (Complex * ) f;

@end


#endif /* Complex_h */
