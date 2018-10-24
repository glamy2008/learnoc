//
//  MTCollectionItem.h
//  MTCompCollectionView
//
//  Created by Jason Li on 2018/3/26.
//

#import <Foundation/Foundation.h>

@import MTComponent;

@interface MTCollectionItem : MTCompServiceModel

@property (nonatomic, strong) NSString *itemTitle; // 标题

@property (nonatomic, strong) NSString *itemImageName; // 背景图片本地名称

@property (nonatomic, strong) NSString *itemImageURL; // 背景图片远程连接

@property (nonatomic) NSInteger index; // 页面排序位置

@end
