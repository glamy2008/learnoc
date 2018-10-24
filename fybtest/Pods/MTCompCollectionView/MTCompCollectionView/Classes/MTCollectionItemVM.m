//
//  MTCollectionItemVM.m
//  MTCompCollectionView
//
//  Created by Jason Li on 2018/3/26.
//

#import "MTCollectionItemVM.h"
#import "MTCollectionItem.h"

@implementation MTCollectionItemVM

- (BOOL)isValidIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.count - 1 < indexPath.row) {
        return NO;
    }
    
    return YES;
}

- (NSString *)itemTitleAtIndexPath:(NSIndexPath *)indexPath {
    return [self collectionItemAtIndexPath:indexPath].itemTitle;
}


- (NSString *)imageNameAtIndexPath:(NSIndexPath *)indexPath {
    return [self collectionItemAtIndexPath:indexPath].itemImageName;
}

- (NSString *)imageURLAtIndexPath:(NSIndexPath *)indexPath {
    return [self collectionItemAtIndexPath:indexPath].itemImageURL;
}

- (MTCollectionItem *)collectionItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isValidIndexPath:indexPath]) {
        return (MTCollectionItem *)self.dataSource[indexPath.row];
    }
    return nil;
}

- (void)toConstructionDataSource {
    for (NSString *key in [self.serviceData allKeys]) {
        [self toDealItemDataSourceWithValue:self.serviceData[key]];
    }
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    [self.dataSource sortUsingDescriptors:@[sort]];
}

- (void)toDealItemDataSourceWithValue:(id)value {
    if ([value isKindOfClass:[NSArray class]]) {
        for (id subValue in value) {
            [self toDealItemDataSourceWithValue:subValue];
        }
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        // 判断字典的深度，如果字典的Key值中包含itemImageName或itemImageURL，是业务数据，否则继续嵌套
        if ([[(NSDictionary *)value allKeys] containsObject:@"itemImageName"] ||
            [[(NSDictionary *)value allKeys] containsObject:@"itemImageURL"]) {
            MTCollectionItem *item = [MTCollectionItem initWithDict:value];
            [self.dataSource addObject:item];
        } else {
            // 继续下探
            for (id subKey in [(NSDictionary *)value allKeys]) {
                [self toDealItemDataSourceWithValue:(NSDictionary *)value[subKey]];
            }
        }
    }
}

@end
