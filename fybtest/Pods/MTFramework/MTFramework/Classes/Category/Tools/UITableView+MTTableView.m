//
//  UITableView+MTTableView.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "UITableView+MTTableView.h"

NSString *const JLRowType = @"JLRowType";

@implementation UITableView (MTTableView)
- (NSUInteger)rowTypeFromArray:(NSArray *)array indexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(indexPath && array.count > 0 && array[indexPath.section] && array[indexPath.section][indexPath.row] && array[indexPath.section][indexPath.row][JLRowType]);
    return [array[indexPath.section][indexPath.row][JLRowType] integerValue];
}

- (NSIndexPath *)indexPathAtRowType:(NSUInteger)rowType fromArray:(NSArray *)array {
    NSParameterAssert(array);
    for (NSInteger i = 0; i < array.count; i++) {
        for (NSInteger j = 0; j < ((NSArray *)array[i]).count; j++) {
            if ([((NSDictionary *)array[i][j])[JLRowType] integerValue] == rowType) {
                return [NSIndexPath indexPathForRow:j inSection:i];
            }
        }
    }
    return nil;
}

- (NSIndexPath *)nextIndexPath:(NSIndexPath *)indexPath fromArray:(NSArray *)array {
    NSParameterAssert(indexPath && array);
    if (array.count - 1 > indexPath.section) {
        if (((NSArray *)array[indexPath.section]).count - 1 > indexPath.row) {
            return [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
        } else {
            return [NSIndexPath indexPathForRow:0 inSection:indexPath.section + 1];
        }
    } else if (array.count - 1 == indexPath.section) {
        if (((NSArray *)array[indexPath.section]).count - 1 > indexPath.row) {
            return [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
        } else {
            return nil;
        }
    }
    return nil;
}

- (NSIndexPath *)lastIndexPath:(NSIndexPath *)indexPath fromArray:(NSArray *)array {
    NSParameterAssert(indexPath && array);
    if (array.count - 1 > indexPath.section && indexPath.section > 0) {
        if (((NSArray *)array[indexPath.section]).count - 1 > indexPath.row &&
            indexPath.row > 0) {
            return [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
        } else if (indexPath.row == 0) {
            return [NSIndexPath indexPathForRow:(((NSArray *)array[indexPath.section - 1]).count - 2) inSection:indexPath.section - 1];
        } else {
            return nil;
        }
    } else if (indexPath.section == 0) {
        if (((NSArray *)array[indexPath.section]).count - 1 > indexPath.row &&
            indexPath.row > 0) {
            return [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
        } else {
            return nil;
        }
    }
    return nil;
}

- (NSInteger)tagFromIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section * 100 + indexPath.row;
}

- (NSIndexPath *)indexPathFromTag:(NSInteger)tag {
    return [NSIndexPath indexPathForRow:(tag%100) inSection:(tag/100)];
}

@end
