//
//  UITableView+MTTableView.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import <UIKit/UIKit.h>

extern NSString *const JLRowType;

@interface UITableView (MTTableView)
/**
 TableView 中通过 indexPath 获取dataSource中的rowType
 
 @param array TableView数据源
 @param indexPath TableViewCell的indexPath
 */
- (NSUInteger)rowTypeFromArray:(NSArray *)array indexPath:(NSIndexPath *)indexPath;
/**
 TableView 中获取指定RowType在dataSource中的indexPath
 
 @param rowType 构造的枚举类型中的一个元素，指定TableView的DataSource中的某一行
 @param array TableView数据源
 */
- (NSIndexPath *)indexPathAtRowType:(NSUInteger)rowType fromArray:(NSArray *)array;


/**
 TableView 中dataSource范围内指定 indexPath 的下一个 indexPath，超出范围 返回nil
 
 @param indexPath 指定的indexPath
 @param array TableView数据源
 */
- (NSIndexPath *)nextIndexPath:(NSIndexPath *)indexPath fromArray:(NSArray *)array;
/**
 TableView 中dataSource范围内指定 indexPath 的前一个 indexPath，超出范围 返回nil
 
 @param indexPath 指定的indexPath
 @param array TableView数据源
 */
- (NSIndexPath *)lastIndexPath:(NSIndexPath *)indexPath fromArray:(NSArray *)array;

/**
 TableView 中将 indexPath 转换为 tag
 
 @param indexPath TableViewCell的indexPath
 */
- (NSInteger)tagFromIndexPath:(NSIndexPath *)indexPath;
/**
 TableView 中将 Tag 转换为 indexPath
 
 @param tag 使用tagFromIndexPath:转换的 tag值
 */
- (NSIndexPath *)indexPathFromTag:(NSInteger)tag;

@end
