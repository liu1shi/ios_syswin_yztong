//
//  BaseViewController.m
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "AFNetworkReachabilityManager.h"
#import "LoginViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //点击空白所有textField自动隐藏键盘
    [self setupForDismissKeyboard];
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;   //default Yes
    self.view.backgroundColor = KColorFFFFFF;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSLog(@"😄😄😄 %@",self);
}

- (void)showHudText:(NSString *)text hideAfter:(CGFloat)HideTime isOnlyText:(BOOL)isOnlyTit isHudCompletion:(HudCompletion)completion {
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    
    if (isOnlyTit) {
        [SVProgressHUD showInfoWithStatus:text];
    } else {
        if (text.length) {
            [SVProgressHUD showWithStatus:text];
        } else {
            [SVProgressHUD show];
        }
    }
    if (HideTime) {
        if (completion) {
            [SVProgressHUD dismissWithDelay:HideTime completion:^{
                completion();
            }];
        } else {
            [SVProgressHUD dismissWithDelay:HideTime];
        }
    }
}

- (void)showHudText:(NSString *)text {
    
    [self showHudText:text hideAfter:3 isOnlyText:YES isHudCompletion:nil];
}

- (void)hideHudCompletion:(HudCompletion)completion {
    if (completion) {
        [SVProgressHUD dismissWithCompletion:^{
            completion();
        }];
    } else {
        [SVProgressHUD dismiss];
    }
}


#pragma mark ---- click
- (void)leftNavButClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushLogin {
    if ([self.navigationController.topViewController class] != [LoginViewController class]) {
        LoginViewController *view = [[LoginViewController alloc] init];
        view.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:view animated:YES];
    }
}

#pragma mark  ---- network


- (void)sendReq:(Basereq *)baseReq hudTit:(NSString *)hudTit isShowHud:(BOOL)isShowHud failTit:(NSString *)failTit isShowFail:(BOOL)isShowFail isReceive:(BOOL)isReceive success:(ReqSuccess)success fail:(ReqFailure)fail {
    
    if (baseReq) {
        
        if (isShowHud) {
            [self showHudText:hudTit hideAfter:0 isOnlyText:NO isHudCompletion:nil];
        }
        
        [ConnectManager sendWithReq:baseReq success:^(Baseres *res) {
            [self hideHudCompletion:nil];
            if (res.code != 1) {
//                if (res.code == 1010 || res.code == 1004) {
//                    [self showHudText:res.message hideAfter:2 isOnlyText:YES isHudCompletion:^{
//
//                        $shared(Public_UserDefault).isLogin = nil;
//                        $shared(Public_UserDefault).cookieStr = nil;
//                        for (NSHTTPCookie *cookie in [PublicMethod cookies]) {
//                            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
//                        }
//                        [self pushLogin];
//                    }];
//                } else {
                    if (isShowFail) {
                        if (failTit.length) {
                            [self showHudText:failTit];
                        } else {
                            [self showHudText:res.message];
                        }
                    }
//                }
            }
            if (success) {
                if (isReceive) {
                    if (res.code == 1) {
                        success(res);
                    }
                } else {
                    success(res);
                }
            }
        } failure:^(NSError *error) {
            [self hideHudCompletion:nil];
            if (isShowFail) {
                if (failTit.length) {
                    [self showHudText:failTit];
                } else {
                    [self showHudText:@"网络请求失败"];
                }
            }
            NSLog(@"reqError---- %@ ---- %@",baseReq.reqUrl,error);
            if (fail) {
                fail(error);
            }
        }];
    }
}



- (void)sendReq:(Basereq *)baseReq success:(ReqSuccess)success fail:(ReqFailure)fail {
    
    [self sendReq:baseReq hudTit:nil isShowHud:NO failTit:nil isShowFail:YES isReceive:YES success:success fail:fail];
    
}

#pragma mark ---- custom view

- (void)alertTitle:(NSString *)title message:(NSString *)message leftTitle:(NSString *)leftTitle actionLeft:(alertLeft)left rightTitle:(NSString *)rightTitle actionRight:(alertRight)right addView:(UIViewController *)viewCtrl {
    
    
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (leftTitle.length) {
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (left) {
                left();
            }
        }];
        [alertCtrl addAction:actionCancel];
    }
    
    if (rightTitle.length) {
        UIAlertAction *actinCommit = [UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (right) {
                right();
            }
        }];
        [alertCtrl addAction:actinCommit];
    }
    [viewCtrl presentViewController:alertCtrl animated:YES completion:nil];
    
}

@end
