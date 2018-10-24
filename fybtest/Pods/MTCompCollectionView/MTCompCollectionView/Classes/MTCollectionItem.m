//
//  MTCollectionItem.m
//  MTCompCollectionView
//
//  Created by Jason Li on 2018/3/26.
//

#import "MTCollectionItem.h"

@import MJExtension;

@implementation MTCollectionItem

+ (instancetype)initWithDict:(NSDictionary *)dict {
    return [MTCollectionItem mj_objectWithKeyValues:dict];
}

@end
