//
//  UILabel+MTLabel.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import <UIKit/UIKit.h>

@interface UILabel (MTLable)
- (CGSize)simpleSize;

- (CGFloat)realHeightInView:(UIView *)view;
- (CGFloat)realHeightInView:(UIView *)view atInsets:(UIEdgeInsets)insets;

@end

@interface UILabel (MTLableAttributeText)
- (void)addAttributeParagraphStyleHeadIndent:(CGFloat)headIndent StyleTailIndent:(CGFloat)tailIndent;

- (void)addAttributeColor:(id)color ragne:(NSRange)range;
- (void)addAttributeFont:(id)font ragne:(NSRange)range;

- (void)addStrikethrough;
- (void)addStrikethroughType:(id)type;
- (void)addStrikethroughColor:(id)color;
- (void)addStrikethroughRange:(NSRange)range;
- (void)addStrikethroughType:(id)type color:(id)color;
- (void)addStrikethroughType:(id)type color:(id)color range:(NSRange)range;

- (void)addUnderline;
- (void)addUnderlineColor:(id)color;
- (void)addUnderlineRange:(NSRange)range;
- (void)addUnderlineType:(id)type;
- (void)addUnderlineType:(id)type color:(id)color;
- (void)addUnderlineType:(id)type color:(id)color range:(NSRange)range;

@end
