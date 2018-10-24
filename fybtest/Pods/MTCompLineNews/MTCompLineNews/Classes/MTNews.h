//
//  MTNews.h
//  MTCompLineNews
//
//  Created by Jason Li on 2018/4/11.
//

#import <Foundation/Foundation.h>

@import MTComponent;

@interface MTNews : MTCompServiceModel

@property (nonatomic, strong) NSString *newsID; // 页面的唯一标识

@property (nonatomic, strong) NSString *title; // 页面标题

@property (nonatomic) NSInteger index; // 页面排序位置

@end
