//
//  NSObject+MTKeyboard.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import <Foundation/Foundation.h>

@protocol MTKeyboardOperProtocol <NSObject>
@optional
- (void)keyboardWillShow;
- (void)keyboardDidShow;

- (void)keyboardWillHide;
- (void)keyboardDidHide;

@end

@interface NSObject (MTKeyboard)<MTKeyboardOperProtocol>

@property (nonatomic, assign) CGFloat originalY;
@property (nonatomic, strong) UIView *keyboardResponseView;

@property (nonatomic, strong) NSNotification *keyboardNotification;

/**
 键盘是否已经显示
 
 @return YES 已经显示，NO未显示
 */
- (BOOL)isShowedKeyboard;

/**
 *  添加键盘通知 配合 addNotificationCenter 使用
 **/
- (void)addKeyboardNotification;
/**
 *  删除键盘通知 配合 removeNotificationCenter 使用
 **/
- (void)removeKeyboardNotification;

@end
