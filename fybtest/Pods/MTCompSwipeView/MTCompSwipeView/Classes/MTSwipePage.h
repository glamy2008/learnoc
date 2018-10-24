//
//  MTSwipePage.h
//  MTCompSwipeView
//
//  Created by Jason Li on 2018/3/16.
//

#import <Foundation/Foundation.h>

@import MTComponent;

@interface MTSwipePage : NSObject
+ (instancetype)initWithDict:(NSDictionary *)dict;

@property (nonatomic, strong) NSString *pageID; // 页面的唯一标识

@property (nonatomic, strong) NSString *title; // 页面标题

@property (nonatomic, strong) NSString *picURL; // 页面图片地址

@property (nonatomic, strong) NSString *landingURL; // 页面详情地址

@property (nonatomic) NSInteger index; // 页面排序位置

@property (nonatomic) BOOL isNativeLanding; // 是否使用原生着陆页 Default No

@property (nonatomic, strong) NSString *landingVCName; // 原生VC对象名称

@property (nonatomic) UITableViewStyle style; // TableViewController 初始化时使用的style


/**
 将页面图片地址转换NSURL

 @return 图片地址链接
 */
- (NSURL *)pagePicURL;

/**
 将着陆页地址转换为NSURL

 @return 着陆页地址链接
 */
- (NSURL *)pageLandingURL;

/**
 将着陆页地址转换为 Request请求对象

 @return 请求对象
 */
- (NSURLRequest *)requestPageLandingURl;

/**
 实例化着陆页试图控制器

 @return 原生VC对象
 */
- (UIViewController<MTComponentProtocol> *)instanceLandingVC;

@end
