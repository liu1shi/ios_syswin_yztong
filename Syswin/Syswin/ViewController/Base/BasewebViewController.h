//
//  BasewebViewController.h
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BasewebViewController : BaseViewController

@property (nonatomic,strong)  UIWebView *webView;
@property (nonatomic,strong)  NSString *localUrl;       //本地的url地址
@property (nonatomic,strong)  NSString *onlineUrl;      //服务器端的url地址

///加载webHtml
- (void)loadHtml;
//webview完成加载后触发
- (void)webviewFinishLoad;
//webview加载失败后触发
- (void)webviewFailLoad;
///js 向native传参 type标识触发的哪个动作 dataArr传来的参数
- (void)wkwebCheckURLtype:(NSString *)type datas:(NSArray *)dataArr;

@end
