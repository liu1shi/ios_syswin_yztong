//
//  BaseViewController.h
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectManager.h"
#import "UIViewController+DismissKeyboard.h"

typedef void (^alertRight)(void);
typedef void (^alertLeft)(void);
typedef void (^HudCompletion)(void);

@interface BaseViewController : UIViewController


/** 简版Hud  只显示文字2秒后隐藏 */
- (void)showHudText:(NSString *)text;

///显示HUD   HideTime多久后隐藏 isOnlyTit是否只提示 isHudCompletion是否执行隐藏后的方法
- (void)showHudText:(NSString *)text hideAfter:(CGFloat)HideTime isOnlyText:(BOOL)isOnlyTit isHudCompletion:(HudCompletion)completion;

///隐藏HUD 后执行方法 isHudCompletion是否执行隐藏后的方法
- (void)hideHudCompletion:(HudCompletion)completion;

/** 简版发送网络请求 不显示Hud 失败显示提示 只返回成功的数据*/
- (void)sendReq:(Basereq *)baseReq success:(ReqSuccess)success fail:(ReqFailure)fail;

///发送网络请求  hudTit发送请求时的HUD提示  isShowHud是否显示HUD failTit发送失败后的提示  isShowFail是否显示失败后的提示 isReceive是否只返回成功的数据
- (void)sendReq:(Basereq *)baseReq hudTit:(NSString *)hudTit isShowHud:(BOOL)isShowHud failTit:(NSString *)failTit isShowFail:(BOOL)isShowFail isReceive:(BOOL)isReceive success:(ReqSuccess)success fail:(ReqFailure)fail;

#pragma mark --- custom view

///alert最多两个按钮的弹出框方法
- (void)alertTitle:(NSString *)title message:(NSString *)message leftTitle:(NSString *)leftTitle actionLeft:(alertLeft)left rightTitle:(NSString *)rightTitle actionRight:(alertRight)right addView:(UIViewController *)viewCtrl;

@end
