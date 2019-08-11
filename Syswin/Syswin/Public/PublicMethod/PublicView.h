//
//  PublicView.h
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//
//  公共的视图方法

#import <Foundation/Foundation.h>

@interface PublicView : NSObject

+ (UIView *)ViewFrame:(CGRect)frame withBackgroundColor:(UIColor *)bColor addView:(UIView *)bview;

///adjustsFitWidth 自适应宽度
+ (UILabel *)LabelFrame:(CGRect)frame
                   Text:(NSString *)aText
            TextAliType:(NSTextAlignment)aTextAliType
                   Font:(UIFont *)font
                  Color:(UIColor *)aColor
              BackColor:(UIColor *)bColor
        adjustsFitWidth:(BOOL)bAdjust
                addView:(UIView *)bview;

+ (UIButton *)ButtonFrame:(CGRect)frame
                imageName:(NSString *)imageName
             selImageName:(NSString *)selImageName
                    title:(NSString *)title
               titleColor:(UIColor *)color
                 selTitle:(NSString *)selTitle
                 selColor:(UIColor *)selColor
                   target:(id)target
                   action:(SEL)action
                  addView:(UIView *)bview;

+ (UIScrollView *)ScrollViewFrame:(CGRect)frame
                    pagingEnabled:(BOOL)isPage
                        showsHori:(BOOL)isShowH
                       showsVerti:(BOOL)isShowV
                          bounces:(BOOL)isBounces
                          addView:(UIView *)bview;

+ (UITextField *)textFieldFrame:(CGRect)frame
                    placeholder:(NSString *)placeholder
                      textColor:(UIColor *)textColor
                           font:(UIFont *)font
                  returnKeyType:(UIReturnKeyType)returnKeyType
                       delegate:(id<UITextFieldDelegate>)delegate
                        addView:(UIView *)bview;

///带左右图标的textField  如输入用户名、密码等功能
+ (UITextField *)textFieldFrame:(CGRect)frame
                    placeholder:(NSString *)placeholder
                      textColor:(UIColor *)textColor
                           font:(UIFont *)font
                  returnKeyType:(UIReturnKeyType)returnKeyType
                       delegate:(id<UITextFieldDelegate>)delegate
                      leftImage:(NSString *)lImageName
                    lImageframe:(CGRect)lImageframe
                     rightImage:(NSString *)rImageName
                    rImageframe:(CGRect)rImageframe
                       selImage:(NSString *)selImage
                         target:(id)target
                    imageAction:(SEL)action
                        addView:(UIView *)bview;


+ (UIImageView *)imageviewFrame:(CGRect)frame
                      imageName:(NSString *)imageName
                         urlStr:(NSString *)urlStr
                    contentMode:(UIViewContentMode)contentMode
                        addView:(UIView *)bview;

+ (UIWebView *)webviewFrame:(CGRect)frame
                    bounces:(BOOL)bounces
                   localStr:(NSString *)localStr
                     urlStr:(NSString *)urlStr
            timeoutInterval:(NSInteger)outtime
                    addView:(UIView *)bview;

+ (void)layerBorderWidth:(CGFloat)width
             borderColor:(UIColor *)color
            cornerRadius:(CGFloat)radius
                 addView:(UIView *)view;

@end
