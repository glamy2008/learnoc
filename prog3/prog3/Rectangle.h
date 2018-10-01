//
//  Rectangle.h
//  prog3
//
//  Created by neusoft on 2018/9/29.
//  Copyright © 2018年 neusoft. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef Rectangle_h
#define Rectangle_h

@class XYPoint;

@interface Rectangle : NSObject

@property int width, height;

-(XYPoint *) origin;

-(void) setOrigin: (XYPoint *) pt;

-(int) area;
-(int) perimeter;
-(void) setWidth: (int) w andHeight: (int) h;

@end


#endif /* Rectangle_h */
