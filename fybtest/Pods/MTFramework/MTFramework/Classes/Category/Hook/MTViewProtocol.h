//
//  MTViewProtocol.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import <Foundation/Foundation.h>

@protocol MTViewProtocol <NSObject>
@optional
- (void)initView;
- (void)initCell; // Olny for UITableViewCell

/**
 在 -layoutSubviews 中调用的方法，实现类可以在其中实现控件的约束布局（多次调用）。
 */
- (void)setupLayoutConstraint;

- (CGFloat)heightView;

@end

@interface UIView (MTView) <MTViewProtocol>

@end

@interface UITableViewCell (MTView) <MTViewProtocol>

@end

@interface UICollectionViewCell (MTView) <MTViewProtocol>

@end

@interface UIViewController (MTView) <MTViewProtocol>

@end
