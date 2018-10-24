//
//  NSString+MTString.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "NSString+MTString.h"

@implementation NSString (MTStringSize)
- (CGSize)sizeByFont:(UIFont *)font {
    return [self sizeByFont:font boundSize:CGSizeZero];
}

- (CGSize)sizeByFont:(UIFont *)font boundSize:(CGSize)size {
    return [self sizeByFont:font boundSize:size lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)sizeByFont:(UIFont *)font boundSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize expectedLabelSize = CGSizeZero;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        if (CGSizeEqualToSize(size, CGSizeZero)) {
            expectedLabelSize = [self sizeWithAttributes:attributes];
        } else {
            expectedLabelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        }
    }
    else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0
        expectedLabelSize = [self sizeWithFont:font
                             constrainedToSize:size
                                 lineBreakMode:lineBreakMode];
#endif
    }
    CGFloat num = ceilf(expectedLabelSize.height)/ceilf(font.lineHeight);
    
    return CGSizeMake(ceilf(expectedLabelSize.width), ceilf(num)*ceilf(font.lineHeight));
}

- (NSRange)range {
    return NSMakeRange(0, self.length);
}

@end


@implementation NSString (MTStringMatchesRegular)

- (BOOL)stringByMatchsRegular:(NSString *)regular {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    return [predicate evaluateWithObject:self];
}

- (BOOL)checkChineseString {
    return [self stringByMatchsRegular:@"^[\\u4e00-\\u9fa5]*$"];
}

- (BOOL)checkEnglishString {
    return [self stringByMatchsRegular:@"^[A-Za-z\\s.-]+$"];
}

- (BOOL)checkLatinAndChinese {
    return [self stringByMatchsRegular:@"^[A-Za-z\\u4e00-\\u9fa5\\s]+$"];
}

- (BOOL)checkNumberString {
    return [self stringByMatchsRegular:@"^[0-9\\s]+$"];
}

- (BOOL)checkNumberAndLetter {
    return [self stringByMatchsRegular:@"^[A-Za-z0-9\\s]+$"];
}

- (BOOL)checkNumberAndLowerCaseLetter {
    return [self stringByMatchsRegular:@"^[a-z0-9\\s]+$"];
}

- (BOOL)checkNumberAndUpperCaseLetter {
    return [self stringByMatchsRegular:@"^[A-Z0-9\\s]+$"];
}

- (BOOL)checkEmojiString {
    __block BOOL returnValue = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];
    
    return returnValue;
}

- (BOOL)check86CellPhoneNumber {
    return [self stringByMatchsRegular:@"^1+[34578]{1}+\\d{9}"];
}

- (BOOL)check86IDCardNumber {
    BOOL isMatch = [self stringByMatchsRegular:@"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}"];
    if (!isMatch) {
        return [self stringByMatchsRegular:@"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X|x)"];
    }
    return isMatch;
}

- (BOOL)checkEmail {
    return [self stringByMatchsRegular:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

@end

@implementation NSString (MTStringFillToLenght)
- (NSString *)fillToLenght:(NSInteger)len
                withString:(NSString *)str
                   isLeft :(BOOL)left {
    if (left) {
        NSString *pro = [@"" stringByPaddingToLength:(len - self.length) withString:str startingAtIndex:0];
        return [pro stringByPaddingToLength:len withString:self startingAtIndex:0];
    }
    return [self stringByPaddingToLength:len withString:str startingAtIndex:0];
}

@end

@implementation NSString (MTStringMetaHTML)
- (NSString *)stringMetaHtml {
    NSMutableString *html = [NSMutableString stringWithString:@"<!doctype html>"];
    [html appendString:@"<html class=\"no-js\">"];
    [html appendString:@"<head>"];
    [html appendString:@"<meta charset=\"utf-8\">"];
    [html appendString:@"<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">"];
    [html appendString:@"<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"];
    [html appendString:@"<meta name=\"renderer\" content=\"webkit\">"];
    [html appendString:@"<meta http-equiv=\"Cache-Control\" content=\"no-siteapp\"/>"];
    [html appendString:@"<meta name=\"mobile-web-app-capable\" content=\"yes\">"];
    [html appendString:@"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\">"];
    [html appendString:@"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">"];
    [html appendString:@"<meta name=\"apple-mobile-web-app-title\" content=\"Amaze UI\"/>"];
    [html appendString:@"<meta name=\"msapplication-TileColor\" content=\"#0e90d2\">"];
    [html appendString:@"<style>html,body{padding:0.4rem;margin:0px;}</style>"];
    [html appendString:@"</head>"];
    [html appendString:@"<body>"];
    [html appendString:@"%@"];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    
    return [NSString stringWithFormat:html,self];
}


@end

//引入IOS自带密码库
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
//空字符串
#define     LocalStr_None           @""

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSString (MTStringEncryption)
- (NSString *)base64String {
    if (self && ![self isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY  改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        //IOS 自带DES加密 Begin  改动了此处
        //data = [self DESEncrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [self base64EncodedStringFrom:data];
    }
    else {
        return LocalStr_None;
    }
}

- (NSString *)stringByBase64 {
    if (self && ![self isEqualToString:LocalStr_None]) {
        //取项目的bundleIdentifier作为KEY   改动了此处
        //NSString *key = [[NSBundle mainBundle] bundleIdentifier];
        NSData *data = [self dataWithBase64EncodedString:self];
        //IOS 自带DES解密 Begin    改动了此处
        //data = [self DESDecrypt:data WithKey:key];
        //IOS 自带DES加密 End
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    else {
        return LocalStr_None;
    }
}

- (NSString *)MD5String {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return [result lowercaseString];
}

/******************************************************************************
 函数名称 : - (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
- (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : - (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
- (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

/******************************************************************************
 函数名称 : - (NSData *)dataWithBase64EncodedString:(NSString *)string
 函数描述 : base64格式字符串转换为文本数据
 输入参数 : (NSString *)string
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 :
 ******************************************************************************/
- (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:@"*** - [%@ %@]: To Base64 String is nil",NSStringFromClass([self class]), NSStringFromSelector(_cmd)];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

/******************************************************************************
 函数名称 : - (NSString *)base64EncodedStringFrom:(NSData *)data
 函数描述 : 文本数据转换为base64格式字符串
 输入参数 : (NSData *)data
 输出参数 : N/A
 返回参数 : (NSString *)
 备注信息 :
 ******************************************************************************/
- (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end
