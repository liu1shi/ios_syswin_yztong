//
//  PublicMethod.h
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ReturnBlock)(BOOL isOpen);

@interface PublicMethod : NSObject

+ (NSString *)homePath;
+ (NSString *)documentPath;
+ (NSString *)resourcePath;
+ (NSString *)md5:(NSString *)str;
///十六进制颜色
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
///正则验证
+ (BOOL)isRegex:(NSString*)regexStr object:(NSString *)objectStr;
/// 是否浮点型
+ (BOOL)isFloat:(NSString*)string;

+ (void)openUrl:(NSString *)url;

/// 获取汉字转成拼音字符串 通讯录模糊搜索 支持拼音检索 首字母 全拼 汉字 搜索
+ (NSString *)transformToPinyin:(NSString *)aString;

///计算文字高度
+ (CGFloat) sizeHeight:(UIView *)view andWidth:(CGFloat)width;
///计算文字宽度
+ (CGFloat) sizeWidth:(UIView *)view andHeight:(CGFloat)height;
///计算文字大小
+ (CGSize) sizeBounding:(NSString *)text font:(UIFont *)font size:(CGSize)size;

+ (NSArray<NSHTTPCookie *> *)cookies;

///将时间戳转化为00：00：00形式的时间  isMillisecond 是否毫秒
+ (NSString *)Time:(NSInteger)timeNum isMillisecond:(BOOL)isMillisecond;

///字典转json字符串
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

//处理 html rtf等富文本  NSHTMLTextDocumentType
+ (NSAttributedString *)attributedString:(NSString *)content type:(NSString *)type;

@end
