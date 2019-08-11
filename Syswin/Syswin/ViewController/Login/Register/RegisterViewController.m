//
//  RegisterViewController.m
//  qhwy
//
//  Created by yang.liu on 18/7/17.
//  Copyright © 2018年 qhwy. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate> {
    
    UIScrollView *scrollview_;
    UITextField *acountTF_;
    UITextField *yzmTF_;
    UITextField *pwTF_;
    UITextField *ywyTF_;
    UIButton *yzmBtn_;
    UIButton *confirmBtn_;
    NSInteger timerCount_;
    UIButton *agreeBtn_;
    UIButton *protBtn_;
    
    NSString *checkCode_;
}


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}


- (void)initData {
    timerCount_ = 60;
}

- (void)initView {
    self.title = @"注册";
    scrollview_ = [PublicView ScrollViewFrame:CGRectZero pagingEnabled:NO showsHori:NO showsVerti:NO bounces:YES addView:self.view];
    scrollview_.backgroundColor = KHexColor(@"#F0F0F0");
    
    UIView *baseAcountView = [PublicView ViewFrame:CGRectMake(0, 0, kScreen_Width, 54) withBackgroundColor:KColorFFFFFF addView:scrollview_];
    acountTF_ = [PublicView textFieldFrame:CGRectZero placeholder:@"请输入手机号码" textColor:KColor333333 font:KFONT16 returnKeyType:UIReturnKeyNext delegate:self addView:baseAcountView];
    [PublicView ViewFrame:CGRectMake(15, 53, kScreen_Width - 30, 1) withBackgroundColor:KHexColor(@"#DFDFDF") addView:baseAcountView];
    
    UIView *baseYzmView = [PublicView ViewFrame:CGRectMake(0, 54, kScreen_Width, 54) withBackgroundColor:KColorFFFFFF addView:scrollview_];
    yzmTF_ = [PublicView textFieldFrame:CGRectZero placeholder:@"请输入验证码" textColor:KColor333333 font:KFONT16 returnKeyType:UIReturnKeyNext delegate:self addView:baseYzmView];;
    yzmBtn_ = [PublicView ButtonFrame:CGRectZero imageName:nil selImageName:nil title:@"获取验证码" titleColor:KHexColor(@"#F83E44") selTitle:nil selColor:nil target:self action:@selector(buttonClick:) addView:baseYzmView];
    yzmBtn_.titleLabel.font = KFONT14;
    [PublicView layerBorderWidth:1 borderColor:KHexColor(@"#F83E44") cornerRadius:4 addView:yzmBtn_];
    [PublicView ViewFrame:CGRectMake(15, 53, kScreen_Width - 30, 1) withBackgroundColor:KHexColor(@"#DFDFDF") addView:baseYzmView];
    
    UIView *basePwView = [PublicView ViewFrame:CGRectMake(0, 108, kScreen_Width, 54) withBackgroundColor:KColorFFFFFF addView:scrollview_];
    pwTF_ = [PublicView textFieldFrame:CGRectZero placeholder:@"请输入登录密码（由6—20位数字和字母组成）" textColor:KColor333333 font:KFONT14 returnKeyType:UIReturnKeyNext delegate:self leftImage:nil lImageframe:CGRectZero rightImage:@"pw_eyeShow" rImageframe:CGRectMake(0, 0, 50, 30) selImage:@"pw_eyeClose" target:self imageAction:@selector(buttonClick:) addView:basePwView];
    pwTF_.secureTextEntry = YES;
    [PublicView ViewFrame:CGRectMake(15, 53, kScreen_Width - 30, 1) withBackgroundColor:KHexColor(@"#DFDFDF") addView:basePwView];
    
    UIView *baseYwyView = [PublicView ViewFrame:CGRectMake(0, 162, kScreen_Width, 54) withBackgroundColor:KColorFFFFFF addView:scrollview_];
    ywyTF_ = [PublicView textFieldFrame:CGRectZero placeholder:@"业务员编号（选填）" textColor:KColor333333 font:KFONT16 returnKeyType:UIReturnKeyNext delegate:self addView:baseYwyView];
    
    agreeBtn_ = [PublicView ButtonFrame:CGRectZero imageName:@"noAgree" selImageName:@"agree" title:@"我已阅读并同意" titleColor:KColor999999 selTitle:nil selColor:nil target:self action:@selector(buttonClick:) addView:scrollview_];
    agreeBtn_.selected = YES;
    agreeBtn_.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    agreeBtn_.titleLabel.font = KFONT12;
    protBtn_ = [PublicView ButtonFrame:CGRectZero imageName:nil selImageName:nil title:@"《汇诚服务协议》" titleColor:KHexColor(@"#F83E44") selTitle:nil selColor:nil target:self action:@selector(buttonClick:) addView:scrollview_];
    protBtn_.titleLabel.font = KFONT12;
    
    confirmBtn_ = [PublicView ButtonFrame:CGRectZero imageName:nil selImageName:nil title:@"注册" titleColor:KColorFFFFFF selTitle:nil selColor:nil target:self action:@selector(buttonClick:) addView:scrollview_];
    confirmBtn_.titleLabel.font = KFONT18;
    confirmBtn_.backgroundColor = KHexColor(@"#F83E44");
    [PublicView layerBorderWidth:0 borderColor:nil cornerRadius:4 addView:confirmBtn_];
    
    
    [scrollview_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [acountTF_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(baseAcountView);
        make.left.equalTo(baseAcountView).offset(15);
        make.right.equalTo(baseAcountView).offset(-15);
    }];
    
    [yzmTF_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(baseYzmView);
        make.left.equalTo(baseYzmView).offset(15);
        make.width.equalTo(@(160));
    }];
    [yzmBtn_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(baseYzmView);
        make.right.equalTo(baseYzmView).offset(-15);
        make.width.equalTo(@(84));
        make.height.equalTo(@(34));
    }];
    [pwTF_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(basePwView);
        make.left.equalTo(basePwView).offset(15);
        make.right.equalTo(basePwView).offset(-15);
    }];
    [ywyTF_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(baseYwyView);
        make.left.equalTo(baseYwyView).offset(15);
        make.right.equalTo(baseYwyView).offset(-15);
    }];
    
    [agreeBtn_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseYwyView.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(15);
        make.width.equalTo(@(110));
        make.height.equalTo(@(20));
    }];
    [protBtn_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseYwyView.mas_bottom).offset(10);
        make.left.equalTo(self->agreeBtn_.mas_right);
        make.width.equalTo(@(100));
        make.height.equalTo(@(20));
    }];
    [confirmBtn_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseYwyView.mas_bottom).offset(100);
        make.bottom.equalTo(self->scrollview_).offset(-100);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@(42));
    }];
}

- (void)usergetRegVerificationCodeReq {
    UsergetRegVerificationCodeReq *req = [[UsergetRegVerificationCodeReq alloc] init];
    req.phoneNumber = acountTF_.text;
    [self sendReq:req hudTit:nil isShowHud:YES failTit:nil isShowFail:YES isReceive:YES success:^(Baseres *res) {
        if ([res isKindOfClass: [UsergetRegVerificationCodeRes class]]) {
            UsergetRegVerificationCodeRes *subRes = (UsergetRegVerificationCodeRes *)res;
            self->checkCode_ = subRes.checkCode;
            NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerRun:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        }
    } fail:nil];
}

- (void)userregReq {
    UserregReq *req = [[UserregReq alloc] init];
    req.phoneNumber = acountTF_.text;
    req.checkCode = checkCode_;
    req.randomCode = yzmTF_.text;
    req.password = pwTF_.text;
    req.salesmanAccount = ywyTF_.text;
    [self sendReq:req hudTit:nil isShowHud:YES failTit:nil isShowFail:YES isReceive:YES success:^(Baseres *res) {
        if ([res isKindOfClass: [UserregRes class]]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:nil];
}

- (BOOL)checkInput {
    BOOL isvalid = YES;
    if (!acountTF_.text.length) {
        isvalid = NO;
        [self showHudText:@"请输入手机号码"];
    } else if (!yzmTF_.text.length) {
        isvalid = NO;
        [self showHudText:@"请输入验证码"];
    } else if (!pwTF_.text.length) {
        isvalid = NO;
        [self showHudText:@"请输入密码"];
    } else if (!agreeBtn_.selected) {
        isvalid = NO;
        [self showHudText:@"请阅读并同意协议"];
    }
    return isvalid;
}

- (void)buttonClick:(id)sender {
    if (yzmBtn_ == sender) {
        if (acountTF_.text.length) {
            [self usergetRegVerificationCodeReq];
        } else {
            [self showHudText:@"请输入手机号码"];
        }
    } else if(confirmBtn_ == sender) {
        if ([self checkInput]) {
            [self userregReq];
        }
    } else if (pwTF_.rightView == sender) {
        UIButton *button = sender;
        button.selected = !button.selected;
        pwTF_.secureTextEntry = !pwTF_.secureTextEntry;
    } else if (agreeBtn_ == sender) {
        agreeBtn_.selected = !agreeBtn_.selected;
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
    if (textField == acountTF_) {
        if (![PublicMethod isRegex:kRegexInteger object:string]) {
            return NO;
        }
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
