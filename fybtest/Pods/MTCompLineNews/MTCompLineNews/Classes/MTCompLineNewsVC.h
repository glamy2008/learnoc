//
//  MTCompLineNewsVC.h
//  AFNetworking
//
//  Created by Jason Li on 2018/4/11.
//

#import <UIKit/UIKit.h>

@import MTComponent;
@import SwipeView;
@import MTBaseObjects;

@interface MTCompLineNewsVC : UIViewController<MTComponentProtocol,
SwipeViewDataSource,SwipeViewDelegate>

@property (nonatomic, strong) UIImageView *titleImageView; // 标题图片

@property (nonatomic, strong) SwipeView *viewSwipe; // 轮播视图

/**
 头条新闻组件名称图片
 
 @return 图片对象
 */
- (UIImage *)lineNewsTitleImage;

/**
 轮播图片自动翻页间隔秒数，默认4秒，子类可覆写
 
 @return 秒数
 */
- (NSTimeInterval)swipeViewAutoScrollTimeInterval;

@end
