//
//  UILabel+MTLabel.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "UILabel+MTLabel.h"

#import "NSString+MTString.h"
#import "UIView+MTView.h"

@implementation UILabel (MTLable)
- (CGSize)simpleSize {
    return [self.text sizeByFont:self.font];
}

- (CGFloat)realHeightInView:(UIView *)view {
    return [self realHeightInView:view atInsets:view.contentInsets];
}

- (CGFloat)realHeightInView:(UIView *)view atInsets:(UIEdgeInsets)insets {
    return [self.text sizeByFont:self.font boundSize:[self contentSizeInView:view atInsets:insets] lineBreakMode:self.lineBreakMode].height;
}

@end

@implementation UILabel (MTLableAttributeText)
- (NSMutableAttributedString *)attributedString {
    NSMutableAttributedString *string = nil;
    if (self.attributedText) {
        string = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    } else {
        string = [[NSMutableAttributedString alloc] initWithString:self.text];
        [string addAttribute:NSFontAttributeName value:self.font range:[self.text range]];
        [string addAttribute:NSForegroundColorAttributeName value:self.textColor range:[self.text range]];
        [string addAttribute:NSBackgroundColorAttributeName value:self.backgroundColor range:[self.text range]];
        
    }
    
    return string;
}

- (void)addAttributeParagraphStyleHeadIndent:(CGFloat)headIndent StyleTailIndent:(CGFloat)tailIndent {
    NSMutableAttributedString *string = [self attributedString];
    
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentJustified;
    style.firstLineHeadIndent = headIndent;
    style.headIndent = headIndent;
    style.tailIndent = tailIndent;
    
    [string removeAttribute:NSParagraphStyleAttributeName range:[self.text range]];
    [string addAttribute:NSParagraphStyleAttributeName value:style range:[self.text range]];
    
    [self setAttributedText:string];
}

- (void)addAttributeFont:(id)font ragne:(NSRange)range {
    NSMutableAttributedString *string = [self attributedString];
    [string removeAttribute:NSFontAttributeName range:range];
    [string addAttribute:NSFontAttributeName value:font range:range];
    
    [self setAttributedText:string];
}

- (void)addAttributeColor:(id)color ragne:(NSRange)range {
    NSMutableAttributedString *string = [self attributedString];
    [string removeAttribute:NSForegroundColorAttributeName range:range];
    [string addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    [self setAttributedText:string];
}

- (void)addStrikethrough {
    [self addStrikethroughType:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) color:[UIColor lightGrayColor] range:[self.text range]];
}

- (void)addStrikethroughColor:(id)color {
    [self addStrikethroughType:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) color:color range:[self.text range]];
}

- (void)addStrikethroughRange:(NSRange)range {
    [self addStrikethroughType:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) color:[UIColor lightGrayColor] range:range];
}

- (void)addStrikethroughType:(id)type {
    [self addStrikethroughType:type color:[UIColor lightGrayColor]];
}

- (void)addStrikethroughType:(id)type color:(id)color {
    [self addStrikethroughType:type color:color range:[self.text range]];
}

- (void)addStrikethroughType:(id)type color:(id)color range:(NSRange)range {
    NSMutableAttributedString *string = [self attributedString];
    [string addAttribute:NSStrikethroughColorAttributeName value:color range:range];
    [string addAttribute:NSStrikethroughStyleAttributeName value:type range:range];
    
    [self setAttributedText:string];
}

- (void)addUnderline {
    [self addUnderlineType:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) color:[UIColor lightGrayColor] range:[self.text range]];
}

- (void)addUnderlineColor:(id)color {
    [self addUnderlineType:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) color:color range:[self.text range]];
}

- (void)addUnderlineRange:(NSRange)range {
    [self addUnderlineType:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) color:[UIColor lightGrayColor] range:range];
}

- (void)addUnderlineType:(id)type {
    [self addUnderlineType:type color:[UIColor lightGrayColor] range:[self.text range]];
}

- (void)addUnderlineType:(id)type color:(id)color {
    [self addUnderlineType:type color:color range:[self.text range]];
}

- (void)addUnderlineType:(id)type color:(id)color range:(NSRange)range {
    NSMutableAttributedString *string = [self attributedString];
    [string addAttribute:NSUnderlineColorAttributeName value:color range:range];
    [string addAttribute:NSUnderlineStyleAttributeName value:type range:range];
    
    [self setAttributedText:string];
}

@end

