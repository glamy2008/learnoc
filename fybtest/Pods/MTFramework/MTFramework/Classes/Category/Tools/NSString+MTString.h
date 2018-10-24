//
//  NSString+MTString.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import <Foundation/Foundation.h>

@interface NSString (MTStringSize)
- (CGSize)sizeByFont:(UIFont *)font;
- (CGSize)sizeByFont:(UIFont *)font boundSize:(CGSize)size;
- (CGSize)sizeByFont:(UIFont *)font boundSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (NSRange)range;

@end

@interface NSString (MTStringMatchesRegular)
/**
 判定字符串是否通过正则表达式约束
 
 @param regular 正则表达式
 @return YES 符合正则，NO
 */
- (BOOL)stringByMatchsRegular:(NSString *)regular;

- (BOOL)checkChineseString;
- (BOOL)checkEnglishString;
- (BOOL)checkLatinAndChinese;

- (BOOL)checkNumberString;
- (BOOL)checkNumberAndLetter;
- (BOOL)checkNumberAndUpperCaseLetter;
- (BOOL)checkNumberAndLowerCaseLetter;

- (BOOL)checkEmojiString;

- (BOOL)check86CellPhoneNumber;
- (BOOL)check86IDCardNumber;
- (BOOL)checkEmail;

@end


@interface NSString (MTStringFillToLenght)
/**
 向字符串分前后添加指定长度的字符
 
 @param len 需要添加的长度
 @param str 添加的字符
 @param left 在字符串的左侧还是右侧，YES为左侧，NO为右侧
 @return 返回调整后的字符串
 */
- (NSString *)fillToLenght:(NSInteger)len
                withString:(NSString *)str
                    isLeft:(BOOL)left;

@end


@interface NSString (MTStringMetaHTML)
/**
 将字符串添加HTML标签，支持屏幕适配
 
 @return 支持屏幕适配的HTML字符
 */
- (NSString *)stringMetaHtml;

@end


@interface NSString (MTStringEncryption)
- (NSString *)base64String;
- (NSString *)stringByBase64;

- (NSString *)MD5String;

@end
