//
//  UIView+MTView.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import <UIKit/UIKit.h>

@protocol MTViewFrameProtocol <NSObject>
@optional

/**
 在 -setContentInsets: 中调用的方法，实现类在设置内边距后可以进行控件的约束布局
 （可以通过调用-setContentInsets:来控制约束布局的调用次数）。
 */
- (void)viewDidChangedContentInsets;

@end

@interface UIView (JLViewFrame)<MTViewFrameProtocol>
@property (nonatomic, assign) UIEdgeInsets contentInsets;

@property (nonatomic, assign) CGFloat view_x;
@property (nonatomic, assign) CGFloat view_y;
@property (nonatomic, assign) CGFloat view_width;
@property (nonatomic, assign) CGFloat view_height;
@property (nonatomic, assign) CGSize view_size;
@property (nonatomic, assign) CGPoint view_origin;

- (CGSize)contentSize;
- (CGSize)contentSizeInView:(UIView *)view;
- (CGSize)contentSizeInView:(UIView *)view atInsets:(UIEdgeInsets)inset;

@end
