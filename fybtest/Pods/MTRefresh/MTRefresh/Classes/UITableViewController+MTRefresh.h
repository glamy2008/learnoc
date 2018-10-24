//
//  UITableViewController+MTRefresh.h
//  MTRefresh
//
//  Created by Jason Li on 2018/3/12.
//

#import <UIKit/UIKit.h>

@import MJRefresh;

@interface UITableViewController (MTRefresh)
@property (nonatomic, assign) BOOL usingRefreshFooter;
@property (nonatomic, assign) BOOL usingRefreshHeader;

@property (nonatomic, strong) MJRefreshFooter *viewRefreshFooter;
@property (nonatomic, strong) MJRefreshHeader *viewRefreshHeader;

- (void)toDealRefreshHeader;
- (void)toDealRefreshFooter;

@end
