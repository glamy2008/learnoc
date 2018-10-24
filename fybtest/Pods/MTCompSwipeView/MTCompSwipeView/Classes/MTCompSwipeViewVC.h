//
//  MTCompSwipeViewVC.h
//  MTCompSwipeView
//
//  Created by Jason Li on 2018/3/16.
//

#import <UIKit/UIKit.h>

@import MTComponent;
@import MTBaseObjects;
@import SwipeView;

@interface MTCompSwipeViewVC : UIViewController<MTComponentProtocol,
SwipeViewDataSource,SwipeViewDelegate>

@property (nonatomic, strong) SwipeView *viewSwipe; // 轮播视图

@property (nonatomic) BOOL hiddenPageControl; // UIPageControl是否隐藏

/**
 轮播图每页中图片加载失败或未加载时显示的默认图片，子类可覆写

 @return 默认图片对象
 */
- (UIImage *)swipeViewDefaultImage;

/**
 轮播图片自动翻页间隔秒数，默认4秒，子类可覆写

 @return 秒数
 */
- (NSTimeInterval)swipeViewAutoScrollTimeInterval;

@end
