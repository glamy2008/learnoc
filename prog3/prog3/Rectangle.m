//
//  Rectangle.m
//  prog3
//
//  Created by neusoft on 2018/9/29.
//  Copyright © 2018年 neusoft. All rights reserved.
//

#include "Rectangle.h"
#include "XYPoint.h"

@implementation Rectangle
{
    XYPoint *origin;
}

@synthesize width, height;

-(int) area
{
    return width * height;
}

-(int) perimeter
{
    return (width + height) * 2;
}

-(void) setWidth:(int)w andHeight:(int)h
{
    width = w;
    height = h;
}

-(XYPoint *) origin {
    return origin;
}

-(void) setOrigin:(XYPoint *)pt
{
    origin = pt;
}


@end
