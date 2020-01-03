//
//  BaseWkViewController.h
//  Syswin
//
//  Created by yang.liu on 2019/8/3.
//  Copyright © 2019 syswin. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseWkViewController : BaseViewController

@property (nonatomic,strong)  WKWebView *webview;
@property (nonatomic,strong)  NSString *localUrl;       //本地的url地址
@property (nonatomic,strong)  NSString *onlineUrl;      //服务器端的url地址

// webview完成加载后触发
- (void)webviewFinish;
// webview加载失败后触发
- (void)webviewFail;
// js 向 native传参, type标识触发的哪个动作, data传来的参数
- (void)jsToNativeType:(NSString *)type data:(id)data;
// native 向 js 传参,data 方法名和参数
- (void)nativeToJs:(NSString *)data;

@end

NS_ASSUME_NONNULL_END
