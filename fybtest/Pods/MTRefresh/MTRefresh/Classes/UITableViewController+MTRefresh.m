//
//  UITableViewController+MTRefresh.m
//  MTRefresh
//
//  Created by Jason Li on 2018/3/12.
//

#import "UITableViewController+MTRefresh.h"
#import <objc/runtime.h>

static const void *usingRefreshHeaderConst = &usingRefreshHeaderConst;
static const void *usingRefreshFooterConst = &usingRefreshFooterConst;

@implementation UITableViewController (MTRefresh)

- (BOOL)usingRefreshHeader {
    return objc_getAssociatedObject(self, usingRefreshHeaderConst);
}

- (void)setUsingRefreshHeader:(BOOL)usingRefreshHeader {
    objc_setAssociatedObject(self, usingRefreshHeaderConst, @(usingRefreshHeader), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (usingRefreshHeader) {
        self.tableView.mj_header = self.viewRefreshHeader;
    } else {
        self.tableView.mj_header = nil;
    }
    
}

- (MJRefreshHeader *)viewRefreshHeader {
    id header = objc_getAssociatedObject(self, @selector(viewRefreshHeader));
    if (header) return header;
    
    self.viewRefreshHeader  = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(toDealRefreshHeader)];
    
    return objc_getAssociatedObject(self, @selector(viewRefreshHeader));
}

- (void)setViewRefreshHeader:(MJRefreshHeader *)viewRefreshHeader {
    objc_setAssociatedObject(self, @selector(viewRefreshHeader), viewRefreshHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)toDealRefreshHeader {
    
}

- (BOOL)usingRefreshFooter {
    return objc_getAssociatedObject(self, usingRefreshFooterConst);
}

- (void)setUsingRefreshFooter:(BOOL)usingRefreshFooter {
    objc_setAssociatedObject(self, usingRefreshFooterConst, @(usingRefreshFooter), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (usingRefreshFooter) {
        self.tableView.mj_footer = self.viewRefreshFooter;
    } else {
        self.tableView.mj_footer = nil;
    }
}

- (MJRefreshFooter *)viewRefreshFooter {
    id footer = objc_getAssociatedObject(self, @selector(viewRefreshFooter));
    if (footer) return footer;
    
    self.viewRefreshFooter  = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(toDealRefreshFooter)];
    [(MJRefreshAutoNormalFooter *)self.viewRefreshFooter setRefreshingTitleHidden:YES];
    
    return objc_getAssociatedObject(self, @selector(viewRefreshFooter));
}

- (void)setViewRefreshFooter:(MJRefreshFooter *)viewRefreshFooter {
    objc_setAssociatedObject(self, @selector(viewRefreshFooter), viewRefreshFooter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)toDealRefreshFooter {
    
}

@end
