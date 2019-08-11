//
//  ForgetPwViewController.m
//  qhwy
//
//  Created by yang.liu on 18/7/17.
//  Copyright © 2018年 qhwy. All rights reserved.
//

#import "ForgetPwViewController.h"
#import "NewPwViewController.h"

@interface ForgetPwViewController ()<UITextFieldDelegate> {
    UITextField *acountTF_;
    UITextField *yzmTF_;
    UIButton *yzmBtn_;
    UIButton *confirmBtn_;
    NSInteger timerCount_;
    
    NSString *checkCode_;
}


@end

@implementation ForgetPwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
    timerCount_ = 60;
}

- (void)initView {
    
    self.view.backgroundColor = KHexColor(@"#F0F0F0");
    
    UIView *baseAcountView = [PublicView ViewFrame:CGRectMake(0, 0, kScreen_Width, 55) withBackgroundColor:KColorFFFFFF addView:self.view];
    UILabel *acountLabel = [PublicView LabelFrame:CGRectZero Text:@"手机号" TextAliType:NSTextAlignmentLeft Font:KFONT16 Color:KColor333333 BackColor:nil adjustsFitWidth:NO addView:baseAcountView];
    acountTF_ = [PublicView textFieldFrame:CGRectZero placeholder:@"请输入手机号码" textColor:KColor333333 font:KFONT16 returnKeyType:UIReturnKeyNext delegate:self addView:baseAcountView];
    
    [PublicView ViewFrame:CGRectMake(15, kSizeH(baseAcountView) - 1, kScreen_Width - 30, 1) withBackgroundColor:KHexColor(@"#DFDFDF") addView:baseAcountView];
    
    UIView *baseYzmView = [PublicView ViewFrame:CGRectMake(0, 55, kScreen_Width, 55) withBackgroundColor:KColorFFFFFF addView:self.view];
    UILabel *yzmLabel = [PublicView LabelFrame:CGRectZero Text:@"验证码" TextAliType:NSTextAlignmentLeft Font:KFONT16 Color:KColor333333 BackColor:nil adjustsFitWidth:NO addView:baseYzmView];
    yzmTF_ = [PublicView textFieldFrame:CGRectZero placeholder:@"请输入验证码" textColor:KColor333333 font:KFONT16 returnKeyType:UIReturnKeyNext delegate:self addView:baseYzmView];
    yzmBtn_ = [PublicView ButtonFrame:CGRectZero imageName:nil selImageName:nil title:@"获取验证码" titleColor:KHexColor(@"#F83E44") selTitle:nil selColor:nil target:self action:@selector(buttonClick:) addView:baseYzmView];
    yzmBtn_.titleLabel.font = KFONT14;
    [PublicView layerBorderWidth:1 borderColor:KHexColor(@"#F83E44") cornerRadius:4 addView:yzmBtn_];

    confirmBtn_ = [PublicView ButtonFrame:CGRectMake(15, kAddH(baseYzmView) + 30, kScreen_Width - 30, 42) imageName:nil selImageName:nil title:@"下一步" titleColor:KColorFFFFFF selTitle:nil selColor:nil target:self action:@selector(buttonClick:) addView:self.view];
    confirmBtn_.titleLabel.font = KFONT18;
    confirmBtn_.backgroundColor = KHexColor(@"#F83E44");
    [PublicView layerBorderWidth:0 borderColor:nil cornerRadius:4 addView:confirmBtn_];
    
    
    [acountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(baseAcountView);
        make.left.equalTo(baseAcountView).offset(15);
    }];
    [acountTF_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(baseAcountView);
        make.left.equalTo(baseAcountView).offset(80);
        make.right.equalTo(baseAcountView).offset(-15);
    }];
    
    [yzmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(baseYzmView);
        make.left.equalTo(baseYzmView).offset(15);
    }];
    [yzmTF_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(baseYzmView);
        make.left.equalTo(baseYzmView).offset(80);
        make.width.equalTo(@(160));
    }];
    [yzmBtn_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(baseYzmView);
        make.right.equalTo(self.view).offset(-15);
        make.width.equalTo(@(80));
        make.height.equalTo(@(34));
    }];
}

- (void)pushNewPw {
    NewPwViewController *vc = [[NewPwViewController alloc] init];
    vc.phoneStr = acountTF_.text;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)usercheckVerificationCodeReq {
    UsercheckVerificationCodeReq *req = [[UsercheckVerificationCodeReq alloc] init];
    req.phoneNumber = acountTF_.text;
    req.checkCode = checkCode_;
    req.randomCode = yzmTF_.text;
    [self sendReq:req hudTit:nil isShowHud:YES failTit:nil isShowFail:YES isReceive:YES success:^(Baseres *res) {
        if ([res isKindOfClass: [UsercheckVerificationCodeRes class]]) {
            [self pushNewPw];
        }
    } fail:nil];
}

- (void)usergetForgetPasswordVerificationCodeReq {
    UsergetForgetPasswordVerificationCodeReq *req = [[UsergetForgetPasswordVerificationCodeReq alloc] init];
    req.phoneNumber = acountTF_.text;
    [self sendReq:req hudTit:nil isShowHud:YES failTit:nil isShowFail:YES isReceive:YES success:^(Baseres *res) {
        if ([res isKindOfClass: [UsergetForgetPasswordVerificationCodeRes class]]) {
            UsergetForgetPasswordVerificationCodeRes *subRes = (UsergetForgetPasswordVerificationCodeRes *)res;
            self->checkCode_ = subRes.checkCode;
            NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerRun:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        }
    } fail:nil];
}

- (BOOL)checkInput {
    BOOL isvalid = YES;
    if (!acountTF_.text.length) {
        isvalid = NO;
        [self showHudText:@"请输入手机号"];
    } else if (!yzmTF_.text.length) {
        isvalid = NO;
        [self showHudText:@"请输入验证码"];
    }
    return isvalid;
}

- (void)buttonClick:(id)sender {
    if (yzmBtn_ == sender) {
        [self usergetForgetPasswordVerificationCodeReq];
    } else if(confirmBtn_ == sender) {
        if ([self checkInput]) {
            [self usercheckVerificationCodeReq];
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
    if (textField == acountTF_) {
        if (![PublicMethod isRegex:kRegexInteger object:string]) {
            return NO;
        }
    }
    return YES;
}

@end
