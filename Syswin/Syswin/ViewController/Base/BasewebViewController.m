//
//  BasewebViewController.m
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BasewebViewController.h"

@interface BasewebViewController ()<UIWebViewDelegate>


@end

@implementation BasewebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    
    self.webView = [[UIWebView alloc] init];
    self.webView.scrollView.bounces = NO;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self loadHtml];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view);
        }
    }];
}

- (void)loadHtml {
    NSURL *url = nil;
    if (_onlineUrl) {
        url = [NSURL URLWithString:_onlineUrl];
    } else if (_localUrl){
        url = [NSURL fileURLWithPath:_localUrl];
    }
    if (url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:20];
        [self.webView loadRequest:request];
        [self showHudText:nil hideAfter:0 isOnlyText:NO isHudCompletion:nil];
    }
}

#pragma mark ---- UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlStr = [request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url_Str=%@",urlStr);
    NSArray *jsDatas = [urlStr componentsSeparatedByString:@":////"];
    if (jsDatas.count > 1) {
        NSArray *datasArr = [jsDatas[1] componentsSeparatedByString:@","];
        [self wkwebCheckURLtype:jsDatas[0] datas:datasArr];
        return NO;
    } else {
        return YES;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hideHudCompletion:nil];
    
    //内存警告策略
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self webviewFinishLoad];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self hideHudCompletion:nil];
    [self showHudText:@"页面加载失败!" hideAfter:2 isOnlyText:YES isHudCompletion:^{
        [self webviewFailLoad];
    }];
}

- (void)webviewFinishLoad {
    
}

- (void)webviewFailLoad {
    
}

///js 向native传参 type标识触发的哪个动作 传来的参数
- (void)wkwebCheckURLtype:(NSString *)type datas:(NSArray *)dataArr{
}

- (void)dealloc {
    
    [self.webView stopLoading];
    self.webView.delegate = nil;
    self.webView = nil;
    
}

@end
