//
//  MTSwipeVM.m
//  MTCompSwipeView
//
//  Created by Jason Li on 2018/3/16.
//

#import "MTSwipeVM.h"

@implementation MTSwipeVM

- (void)toConstructionDataSource {
    for (NSString *key in [self.serviceData allKeys]) {
        [self toDealSwipePageDataSourceWithValue:self.serviceData[key]];
    }
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    [self.dataSource sortUsingDescriptors:@[sort]];
}

- (void)toDealSwipePageDataSourceWithValue:(id)value {
    if ([value isKindOfClass:[NSArray class]]) {
        for (id subValue in value) {
            [self toDealSwipePageDataSourceWithValue:subValue];
        }
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        // 判断字典的深度，如果字典的Key值中包含pageID任务是业务数据，否则继续嵌套
        if ([[(NSDictionary *)value allKeys] containsObject:@"pageID"]) {
            MTSwipePage *page = [MTSwipePage initWithDict:value];
            [self.dataSource addObject:page];
        } else {
            // 继续下探
            for (id subKey in [(NSDictionary *)value allKeys]) {
                [self toDealSwipePageDataSourceWithValue:(NSDictionary *)value[subKey]];
            }
        }
    }
}

@end
