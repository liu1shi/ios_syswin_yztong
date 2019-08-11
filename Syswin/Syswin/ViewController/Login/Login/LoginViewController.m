//
//  LoginViewController.m
//  qhwy
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPwViewController.h"

@interface LoginViewController ()<UITextFieldDelegate> {
    UIScrollView *scrollview_;
    
    UITextField *acountTF_;
    UITextField *pwTF_;
    
    UITextField *phoneTf_;
    UITextField *yzmTf_;
    UIButton *yzmBtn_;
    
    UIButton *accountBtn_;
    UIButton *dxBtn_;
    UIButton *loginBtn_;
    UIButton *registBtn_;
    UIButton *forgetPWBtn_;
    
    BOOL isAcount_;
    NSInteger timerCount_;
    NSString *checkCode_;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}


- (void)initData {
    isAcount_ = YES;
    timerCount_ = 60;
}

- (void)initView {
    
    self.title = @"登录";
    
    scrollview_ = [PublicView ScrollViewFrame:CGRectZero pagingEnabled:NO showsHori:NO showsVerti:NO bounces:NO addView:self.view];
    
    accountBtn_  = [PublicView ButtonFrame:CGRectMake(40, 25, 80, 22) imageName:nil selImageName:nil title:@"账号密码" titleColor:KColor333333 selTitle:nil selColor:nil target:self action:@selector(buttonClick:) addView:scrollview_];
    dxBtn_  = [PublicView ButtonFrame:CGRectMake(kScreen_Width - 122, 25, 90, 22) imageName:nil selImageName:nil title:@"短信验证码" titleColor:KColor999999 selTitle:nil selColor:nil target:self action:@selector(buttonClick:) addView:scrollview_];
    
    acountTF_ = [PublicView textFieldFrame:CGRectMake(32, 80, kScreen_Width - 64, 30) placeholder:@"请输入账号" textColor:KColor333333 font:KFONT16 returnKeyType:UIReturnKeyNext delegate:self leftImage:@"acount" lImageframe:CGRectMake(0, 0, 50, 30) rightImage:nil rImageframe:CGRectZero selImage:nil target:self imageAction:nil addView:scrollview_];
    [PublicView ViewFrame:CGRectMake(32, kAddH(acountTF_), kScreen_Width - 64, 1) withBackgroundColor:KHexColor(@"#DFDFDF") addView:scrollview_];
    pwTF_ = [PublicView textFieldFrame:CGRectMake(32, 134, kScreen_Width - 64, 30) placeholder:@"请输入登录密码" textColor:KColor333333 font:KFONT14 returnKeyType:UIReturnKeyNext delegate:self leftImage:@"pw" lImageframe:CGRectMake(0, 0, 50, 30) rightImage:@"pw_eyeShow" rImageframe:CGRectMake(0, 0, 50, 30) selImage:@"pw_eyeClose" target:self imageAction:@selector(buttonClick:) addView:scrollview_];
    pwTF_.secureTextEntry = YES;
    [PublicView ViewFrame:CGRectMake(32, kAddH(pwTF_), kScreen_Width - 64, 1) withBackgroundColor:KHexColor(@"#DFDFDF") addView:scrollview_];
    
    phoneTf_ = [PublicView textFieldFrame:CGRectMake(45, 80, kScreen_Width - 90, 30) placeholder:@"请输入手机号码" textColor:KColor333333 font:KFONT16 returnKeyType:UIReturnKeyNext delegate:self addView:scrollview_];
    yzmTf_    = [PublicView textFieldFrame:CGRectMake(45, 134, 160, 30) placeholder:@"请输入验证码" textColor:KColor333333 font:KFONT16 returnKeyType:UIReturnKeyNext delegate:self addView:scrollview_];
    yzmBtn_ = [PublicView ButtonFrame:CGRectMake(kScreen_Width - 118, kOriginY(yzmTf_) - 9, 84, 34) imageName:nil selImageName:nil title:@"获取验证码" titleColor:KHexColor(@"#F83E44") selTitle:nil selColor:nil target:self action:@selector(buttonClick:) addView:scrollview_];
    yzmBtn_.titleLabel.font = KFONT14;
    [PublicView layerBorderWidth:1 borderColor:KHexColor(@"#F83E44") cornerRadius:4 addView:yzmBtn_];
    phoneTf_.hidden = YES;
    yzmTf_.hidden = YES;
    yzmBtn_.hidden = YES;
    
    loginBtn_ = [PublicView ButtonFrame:CGRectZero imageName:nil selImageName:nil title:@"登录" titleColor:KColorFFFFFF selTitle:nil selColor:nil target:self action:@selector(buttonClick:) addView:scrollview_];
    loginBtn_.backgroundColor = KHexColor(@"#F83E44");
    loginBtn_.titleLabel.font = KFONT18;
    [PublicView layerBorderWidth:0 borderColor:nil cornerRadius:4 addView:loginBtn_];
    registBtn_ = [PublicView ButtonFrame:CGRectZero imageName:nil selImageName:nil title:@"注册账号" titleColor:KColor999999 selTitle:nil selColor:nil target:self action:@selector(buttonClick:) addView:scrollview_];
    registBtn_.titleLabel.font = KFONT14;
    forgetPWBtn_ = [PublicView ButtonFrame:CGRectZero imageName:nil selImageName:nil title:@"忘记密码" titleColor:KColor999999 selTitle:nil selColor:nil target:self action:@selector(buttonClick:) addView:scrollview_];
    forgetPWBtn_.titleLabel.font = KFONT14;
    
    
    [scrollview_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [loginBtn_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->pwTF_.mas_bottom).offset(36);
        make.bottom.equalTo(self->scrollview_).offset(-145);
        make.left.equalTo(self.view).offset(32);
        make.right.equalTo(self.view).offset(-32);
        make.height.equalTo(@(42));
    }];
    [registBtn_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->loginBtn_.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(32);
        make.width.equalTo(@(60));
        make.height.equalTo(@(30));
    }];
    [forgetPWBtn_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->loginBtn_.mas_bottom).offset(15);
        make.right.equalTo(self.view).offset(-32);
        make.width.equalTo(@(60));
        make.height.equalTo(@(30));
    }];
}

- (void)userloginReq {
    UserloginReq *req = [[UserloginReq alloc] init];
    if (isAcount_) {
        req.phoneNumber = acountTF_.text;
        req.loginType = @"1";
        req.password = pwTF_.text;
    } else {
        req.phoneNumber = phoneTf_.text;
        req.loginType = @"1";
        req.checkCode = checkCode_;
        req.randomCode = yzmTf_.text;
    }
    [self sendReq:req hudTit:nil isShowHud:YES failTit:nil isShowFail:YES isReceive:YES success:^(Baseres *res) {
        if ([res isKindOfClass:[UserloginRes class]]) {
            $shared(Public_UserDefault).isLogin = YES;
            if (self->isAcount_) {
                $shared(Public_UserDefault).phoneStr = self->acountTF_.text;
            } else {
                $shared(Public_UserDefault).phoneStr = self->phoneTf_.text;
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:nil];
}

- (void)usergetLoginVerificationCodeReq {
    UsergetLoginVerificationCodeReq *req = [[UsergetLoginVerificationCodeReq alloc] init];
    req.phoneNumber = phoneTf_.text;
    [self sendReq:req hudTit:nil isShowHud:YES failTit:nil isShowFail:YES isReceive:YES success:^(Baseres *res) {
        if ([res isKindOfClass:[UsergetLoginVerificationCodeRes class]]) {
            UsergetLoginVerificationCodeRes *subRes = (UsergetLoginVerificationCodeRes *)res;
            self->checkCode_ = subRes.checkCode;
            NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerRun:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        }
    } fail:nil];
}

- (BOOL)checkInput {
    BOOL isvalid = YES;
    if (isAcount_) {
        if (!acountTF_.text.length) {
            isvalid = NO;
            [self showHudText:@"请输入账号"];
        } else if (!pwTF_.text.length) {
            isvalid = NO;
            [self showHudText:@"请输入密码"];
        }
    } else {
        if (!phoneTf_.text.length) {
            isvalid = NO;
            [self showHudText:@"请输入手机号码"];
        } else if (!yzmTf_.text.length) {
            isvalid = NO;
            [self showHudText:@"请输入短信验证码"];
        }
    }
    return isvalid;
}


- (void)buttonClick:(id)sender {
    
    if(registBtn_ == sender) {
        RegisterViewController *regi = [[RegisterViewController alloc] init];
        [self.navigationController pushViewController:regi animated:YES];
    } else if(forgetPWBtn_ == sender) {
        ForgetPwViewController *regi = [[ForgetPwViewController alloc] init];
        regi.title = @"忘记密码";
        [self.navigationController pushViewController:regi animated:YES];
    } else if (pwTF_.rightView == sender) {
        UIButton *button = sender;
        button.selected = !button.selected;
        pwTF_.secureTextEntry = !pwTF_.secureTextEntry;
    } else if(loginBtn_ == sender) {
        if ([self checkInput]) {
            [self userloginReq];
        }
    } else if (accountBtn_ == sender) {
        [accountBtn_ setTitleColor:KColor333333 forState:UIControlStateNormal];
        [dxBtn_ setTitleColor:KColor999999 forState:UIControlStateNormal];
        acountTF_.hidden = NO;
        pwTF_.hidden = NO;
        phoneTf_.hidden = YES;
        yzmTf_.hidden = YES;
        yzmBtn_.hidden = YES;
        isAcount_ = YES;
    } else if (dxBtn_ == sender) {
        [accountBtn_ setTitleColor:KColor999999 forState:UIControlStateNormal];
        [dxBtn_ setTitleColor:KColor333333 forState:UIControlStateNormal];
        acountTF_.hidden = YES;
        phoneTf_.hidden = NO;
        pwTF_.hidden = YES;
        yzmTf_.hidden = NO;
        yzmBtn_.hidden = NO;
        isAcount_ = NO;
    } else if (yzmBtn_ == sender) {
        if (phoneTf_.text.length) {
            [self usergetLoginVerificationCodeReq];
        } else {
            [self showHudText:@"请输入手机号码"];
        }
    }
}

- (void)timerRun:(NSTimer *)sender {
    
    [yzmBtn_ setTitle:[NSString stringWithFormat:@"%ld",timerCount_] forState:UIControlStateNormal];
    timerCount_ --;
    yzmBtn_.enabled = NO;
    
    if (timerCount_ <= 0) {
        timerCount_ = 60;
        [yzmBtn_ setTitle:@"获取验证码" forState:UIControlStateNormal];
        yzmBtn_.enabled = YES;
        [sender invalidate];
        sender = nil;
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == phoneTf_ || textField == acountTF_) {
        if (![PublicMethod isRegex:kRegexInteger object:string]) {
            return NO;
        }
    }
    return YES;
}

@end
