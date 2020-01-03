//
//  BaseWkViewController.m
//  Syswin
//
//  Created by yang.liu on 2019/8/3.
//  Copyright © 2019 syswin. All rights reserved.
//

#import "BaseWkViewController.h"

@interface BaseWkViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>{
    WKUserContentController *_userController;
}

@end

@implementation BaseWkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self initView];
}

- (void)initView {
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    _userController = [[WKUserContentController alloc] init];
    
    WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource: @"document.cookie = 'skey=skeyValue';" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [_userController addUserScript:cookieScript];
    
    configuration.userContentController = _userController;
    
//    WKPreferences *preferences = [WKPreferences new];
//    preferences.javaScriptCanOpenWindowsAutomatically = YES;
//    preferences.minimumFontSize = 40.0;
//    [preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
//    configuration.preferences = preferences;
    
    
    configuration.allowsInlineMediaPlayback = YES;
    
    //先添加
    [_userController addScriptMessageHandler:self name:kJsSaveImage];
    [_userController addScriptMessageHandler:self name:kJsCamera];
    [_userController addScriptMessageHandler:self name:kJsWechatPay];
    
    self.webview = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    self.webview.allowsBackForwardNavigationGestures = YES;
    self.webview.navigationDelegate = self;
    self.webview.UIDelegate = self;
    [self.view addSubview:self.webview];
    
    if (_localUrl) {
        [self setLocalUrl:_localUrl];
    } else if(_onlineUrl) {
        [self setOnlineUrl:_onlineUrl];
    }
    
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.bottom.equalTo(self.view);
            make.top.equalTo(self.view);
        }
    }];
}

- (void)setLocalUrl:(NSString *)localUrl {
    _localUrl = localUrl;
    NSURL *url = [NSURL fileURLWithPath:localUrl];
    [self loadHtml:url];
}

- (void)setOnlineUrl:(NSString *)onlineUrl {
    _onlineUrl = onlineUrl;
    NSURL *url = [NSURL URLWithString:_onlineUrl];
    [self loadHtml:url];
}

- (void)loadHtml:(NSURL *)url {
    if (url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:20];
        [self.webview loadRequest:request];
        [self showHudText:nil hideAfter:20 isOnlyText:NO isHudCompletion:nil];
    }
}

#pragma mark ---- WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView
createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration
   forNavigationAction:(WKNavigationAction *)navigationAction
        windowFeatures:(WKWindowFeatures *)windowFeatures {
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (!frameInfo) {
        NSString *urlStr = navigationAction.request.URL.absoluteString;
        [PublicMethod openUrl:urlStr];
    }
    return nil;
}

- (void)webView:(WKWebView *)webView
runJavaScriptAlertPanelWithMessage:(NSString *)message
initiatedByFrame:(WKFrameInfo *)frame
completionHandler:(void (^)(void))completionHandler {

    [self alertTitle:@"提示" message:message leftTitle:@"确定" actionLeft:^{
        completionHandler();
    } rightTitle:nil actionRight:nil addView:self];
}

- (void)webView:(WKWebView *)webView
runJavaScriptConfirmPanelWithMessage:(nonnull NSString *)message
initiatedByFrame:(nonnull WKFrameInfo *)frame
completionHandler:(nonnull void (^)(BOOL))completionHandler {
    [self alertTitle:nil message:message leftTitle:@"取消" actionLeft:^{
        completionHandler(NO);
    } rightTitle:@"确定" actionRight:^{
        completionHandler(YES);
    } addView:self];
}

//- (void)webView:(WKWebView *)webView
//runJavaScriptTextInputPanelWithPrompt:(nonnull NSString *)prompt
//    defaultText:(nullable NSString *)defaultText
//initiatedByFrame:(nonnull WKFrameInfo *)frame
//completionHandler:(nonnull void (^)(NSString * _Nullable))completionHandler {
//
//    // alert弹出框
//    UIAlertController *alertController =
//    [UIAlertController alertControllerWithTitle:prompt
//                                        message:nil
//                                 preferredStyle:UIAlertControllerStyleAlert];
//    // 输入框
//    [alertController
//     addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//         textField.placeholder = defaultText;
//     }];
//
//    // 确定按钮
//    [alertController addAction:[UIAlertAction
//                                actionWithTitle:@"确定"
//                                style:UIAlertActionStyleDefault
//                                handler:^(UIAlertAction * _Nonnull action){
//                                    // 返回用户输入的信息
//                                    UITextField *textField = alertController.textFields.firstObject;
//                                    completionHandler(textField.text);
//                                }]];
//    // 显示
//    [self presentViewController:alertController animated:YES completion:nil];
//}


#pragma mark ---- WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView
didFinishNavigation:(WKNavigation *)navigation {
    [self hideHudCompletion:nil];
    //内存警告策略
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self webviewFinishLoad];
}

- (void)webView:(WKWebView *)webView
didFailProvisionalNavigation:(WKNavigation *)navigation{
    [self hideHudCompletion:nil];
    [self showHudText:@"页面加载失败!" hideAfter:2 isOnlyText:YES isHudCompletion:^{
        [self webviewFailLoad];
    }];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL *URL = navigationAction.request.URL;
    NSLog(@"%@",[URL absoluteString])
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {

    [self jsToNativeType:message.name data:message.body];
}


- (void)webviewFinish {
    
}

- (void)webviewFail {
    
}

- (void)jsToNativeType:(NSString *)type data:(id)data {
    //js 发送数据方法
    // window.webkit.messageHandlers.share.postMessage({title:'标题',content:'内容'});
}

- (void)nativeToJs:(NSString *)data {
    // share('')
    [_webview evaluateJavaScript:data completionHandler:nil];
}

- (void)jsDealloc {
    [_userController removeScriptMessageHandlerForName:kJsSaveImage];
    [_userController removeScriptMessageHandlerForName:kJsCamera];
    [_userController removeScriptMessageHandlerForName:kJsWechatPay];
}

- (void)dealloc {
    [self jsDealloc];
}

@end
