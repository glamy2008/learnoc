//
//  UITableViewController+MTCoreData.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

@import UIKit;
@import CoreData;

@protocol MTCoreDataFetchedConfigCellProtocol <NSObject>
@optional
/**
 CoreData刷新Cell时调用该协议，实现Cell数据的刷新
 
 @param cell 指定的Cell对象
 @param indexPath 需要刷新的indexPath
 */
- (void)fetchedConfigCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@interface UITableViewController (MTCoreData) <NSFetchedResultsControllerDelegate,MTCoreDataFetchedConfigCellProtocol>

@end

