//
//  PublicMethod.m
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PublicMethod.h"
#include <sys/utsname.h>
#import <CommonCrypto/CommonDigest.h>
#import <AVFoundation/AVFoundation.h>
#import <UserNotifications/UserNotifications.h>

#define DEFAULT_VOID_COLOR [UIColor whiteColor]

@implementation PublicMethod

+ (NSString *)homePath {
    return NSHomeDirectory();
}


+ (NSString *)documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)resourcePath {
    return [[NSBundle mainBundle] resourcePath];
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//16进制颜色(html颜色值)字符串转为UIColor
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return DEFAULT_VOID_COLOR;
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return DEFAULT_VOID_COLOR;
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//正则验证
+ (BOOL)isRegex:(NSString*)regexStr object:(NSString *)objectStr {
    NSString *regex = regexStr;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject: objectStr];
}

+ (BOOL)isFloat:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (void)openUrl:(NSString *)url {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}


+ (NSString *)transformToPinyin:(NSString *)aString {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    
    for (int  i = 0; i < pinyinArray.count; i++)
    {
        
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];//区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
            
        }
        [allString appendString:@","];
        count ++;
        
    }
    
    NSMutableString *initialStr = [NSMutableString new];//拼音首字母
    
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    
    return allString;
}

///计算文字高度
+ (CGFloat) sizeHeight:(UIView *)view andWidth:(CGFloat)width{
    CGSize sizeToFit = [view sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

///计算文字宽度
+ (CGFloat) sizeWidth:(UIView *)view andHeight:(CGFloat)height{
    CGSize sizeToFit = [view sizeThatFits:CGSizeMake(MAXFLOAT, height)];
    return sizeToFit.width;
}


///计算文字大小
+ (CGSize) sizeBounding:(NSString *)text font:(UIFont *)font size:(CGSize)size{
    
    NSDictionary *dic = @{NSFontAttributeName:font};
    return [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;

}

+ (NSArray<NSHTTPCookie *> *)cookies {
    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    if ([sharedHTTPCookieStorage cookieAcceptPolicy] != NSHTTPCookieAcceptPolicyAlways) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    }
    
    NSArray         *cookies = [sharedHTTPCookieStorage cookiesForURL:[NSURL URLWithString:kMainHost]];
    return cookies;
}

+ (NSString *)Time:(NSInteger)timeNum isMillisecond:(BOOL)isMillisecond {
    if (isMillisecond) {
        NSInteger seconds = timeNum / 1000 % 60;
        NSInteger minutes = (timeNum / 1000 / 60) % 60;
        NSInteger hours = timeNum / 1000 / 3600;
        return  [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours,minutes,seconds];
    } else {
        NSInteger seconds = timeNum % 60;
        NSInteger minutes = (timeNum / 60) % 60;
        NSInteger hours = timeNum / 3600;
        return  [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hours,minutes,seconds];
    }
}


+ (NSString *)convertToJsonData:(NSDictionary *)dict {
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

+ (NSAttributedString *)attributedString:(NSString *)content type:(NSString *)type {
    
    NSDictionary *dic = @{NSDocumentTypeDocumentOption:type,
                          NSCharacterEncodingDocumentAttribute:@(NSUTF8StringEncoding)
                          };
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *mstring = [[NSAttributedString alloc] initWithData:data options:dic documentAttributes:nil error:nil];
    return mstring;
}


@end
