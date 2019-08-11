//
//  PublicView.m
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PublicView.h"

@implementation PublicView

+ (UIView *)ViewFrame:(CGRect)frame withBackgroundColor:(UIColor *)bColor addView:(UIView *)bview {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.layer.masksToBounds = YES;
    view.backgroundColor = bColor ? bColor : [UIColor clearColor];
    if (bview) {
        [bview addSubview:view];
    }
    return view;
}

+ (UILabel *)LabelFrame:(CGRect)frame
                   Text:(NSString *)aText
            TextAliType:(NSTextAlignment)aTextAliType
                   Font:(UIFont *)font
                  Color:(UIColor *)aColor
              BackColor:(UIColor *)bColor
        adjustsFitWidth:(BOOL)bAdjust
                addView:(UIView *)bview {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.layer.masksToBounds = YES;
    [label setBackgroundColor:(bColor ? bColor:[UIColor clearColor])];
    [label setText:aText];
    [label setTextAlignment:aTextAliType];
    if (font) {
        label.font = font;
    }
    [label setTextColor:aColor ? aColor : [UIColor blackColor]];
    label.adjustsFontSizeToFitWidth = bAdjust;
    if (bview) {
        [bview addSubview:label];
    }
    return label;
}


+ (UIButton *)ButtonFrame:(CGRect)frame
                imageName:(NSString *)imageName
             selImageName:(NSString *)selImageName
                    title:(NSString *)title
               titleColor:(UIColor *)color
                 selTitle:(NSString *)selTitle
                 selColor:(UIColor *)selColor
                   target:(id)target
                   action:(SEL)action
                  addView:(UIView *)bview {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.clipsToBounds = YES;
    [button setAdjustsImageWhenHighlighted:NO];
    button.frame = frame;
    if (title.length) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    if (selTitle.length) {
        [button setTitle:selTitle forState:UIControlStateSelected];
    }
    if (selColor) {
        [button setTitleColor:selColor forState:UIControlStateSelected];
    }
    if (imageName.length) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (selImageName.length) {
        [button setImage:[UIImage imageNamed:selImageName] forState:UIControlStateSelected];
    }
    button.titleLabel.font=[UIFont systemFontOfSize:16];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (bview) {
        [bview addSubview:button];
    }
    return button;
}

+ (UIScrollView *)ScrollViewFrame:(CGRect)frame
                    pagingEnabled:(BOOL)isPage
                        showsHori:(BOOL)isShowH
                       showsVerti:(BOOL)isShowV
                          bounces:(BOOL)isBounces
                          addView:(UIView *)bview {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.scrollsToTop = NO;
    scrollView.pagingEnabled = isPage;
    scrollView.showsHorizontalScrollIndicator = isShowH;
    scrollView.showsVerticalScrollIndicator = isShowV;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.bounces = isBounces;
    if (bview) {
        [bview addSubview:scrollView];
    }
    return scrollView;
}

+ (UITextField *)textFieldFrame:(CGRect)frame
                    placeholder:(NSString *)placeholder
                      textColor:(UIColor *)textColor
                           font:(UIFont *)font
                  returnKeyType:(UIReturnKeyType)returnKeyType
                       delegate:(id<UITextFieldDelegate>)delegate
                        addView:(UIView *)bview{
    UITextField *tf = [[UITextField alloc] initWithFrame:frame];
    tf.placeholder = placeholder;
    tf.textColor = textColor;
    tf.font = font;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.returnKeyType = returnKeyType;
    tf.delegate = delegate;
    if (bview) {
        [bview addSubview:tf];
    }
    return tf;
}

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
                        addView:(UIView *)bview {
    
    UITextField *textfield = [PublicView textFieldFrame:frame placeholder:placeholder textColor:textColor font:font returnKeyType:returnKeyType delegate:delegate addView:bview];
    if (lImageName.length) {
        UIButton *rightBut = [PublicView ButtonFrame:lImageframe imageName:lImageName selImageName:selImage title:nil titleColor:nil selTitle:nil selColor:nil target:target action:action addView:bview];
        textfield.leftView = rightBut;
        textfield.leftViewMode = UITextFieldViewModeAlways;
    }
    
    if (rImageName.length) {
        UIButton *rightBut = [PublicView ButtonFrame:rImageframe imageName:rImageName selImageName:selImage title:nil titleColor:nil selTitle:nil selColor:nil target:target action:action addView:bview];
        textfield.rightView = rightBut;
        textfield.rightViewMode = UITextFieldViewModeAlways;
    }
    return textfield;
}

+ (UIImageView *)imageviewFrame:(CGRect)frame
                      imageName:(NSString *)imageName
                         urlStr:(NSString *)urlStr
                    contentMode:(UIViewContentMode)contentMode
                        addView:(UIView *)bview {
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:frame];
    if (urlStr.length) {
        [imageV sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    } else {
    
            if (imageName.length) {
                imageV.image = [UIImage imageNamed:imageName];
            }
    }
    imageV.contentMode = contentMode;
    if (bview) {
        [bview addSubview:imageV];
    }
    return imageV;
}

+ (UIWebView *)webviewFrame:(CGRect)frame
                    bounces:(BOOL)bounces
                   localStr:(NSString *)localStr
                       urlStr:(NSString *)urlStr
                  timeoutInterval:(NSInteger)outtime
                      addView:(UIView *)bview  {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];
    webView.scrollView.bounces = bounces;
    NSURL *url = nil;
    if (urlStr.length) {
        url = [NSURL URLWithString:urlStr];
    } else{
        if (localStr.length) {
            url = [NSURL fileURLWithPath:localStr];
        }
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:outtime];
    [webView loadRequest:request];
    if (bview) {
        [bview addSubview:webView];
    }
    return webView;
}

+ (void)layerBorderWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)radius addView:(UIView *)view {
    
    view.layer.borderWidth = width;
    
    if (color) {
        view.layer.borderColor = color.CGColor;
    }
    view.layer.cornerRadius = radius;
}

@end
