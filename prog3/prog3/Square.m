//
//  Square.m
//  prog3
//
//  Created by neusoft on 2018/9/29.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#include "Square.h"

@implementation Square

-(void) setSide:(int)s
{
    [self setWidth: s andHeight: s];
}

-(int) side
{
    return self.width;
}

@end
