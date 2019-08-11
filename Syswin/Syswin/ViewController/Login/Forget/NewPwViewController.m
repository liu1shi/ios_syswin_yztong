//
//  NewPwViewController.m
//  Fyd
//
//  Created by mac on 2019/3/13.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NewPwViewController.h"

@interface NewPwViewController ()<UITextFieldDelegate> {
    UITextField *pwTf_;
    UITextField *newPwTf_;
    UIButton *confirmBtn_;
}

@end

@implementation NewPwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initData {
   
}

- (void)initView {
    
    self.title = @"忘记密码";
    self.view.backgroundColor = KHexColor(@"#F0F0F0");
    
    UIView *basePwView = [PublicView ViewFrame:CGRectMake(0, 0, kScreen_Width, 55) withBackgroundColor:KColorFFFFFF addView:self.view];
    pwTf_ = [PublicView textFieldFrame:CGRectZero placeholder:@"新密码（由6—20位数字和字母组成）" textColor:KColor333333 font:KFONT14 returnKeyType:UIReturnKeyNext delegate:self leftImage:nil lImageframe:CGRectZero rightImage:@"pw_eyeShow" rImageframe:CGRectMake(0, 0, 50, 30) selImage:@"pw_eyeClose" target:self imageAction:@selector(buttonClick:) addView:basePwView];
    [PublicView ViewFrame:CGRectMake(15, 54, kScreen_Width - 30, 1) withBackgroundColor:KHexColor(@"#DFDFDF") addView:basePwView];
    
    UIView *baseNewPwView = [PublicView ViewFrame:CGRectMake(0, 55, kScreen_Width, 55) withBackgroundColor:KColorFFFFFF addView:self.view];
    newPwTf_ = [PublicView textFieldFrame:CGRectZero placeholder:@"确认新密码" textColor:KColor333333 font:KFONT14 returnKeyType:UIReturnKeyNext delegate:self leftImage:nil lImageframe:CGRectZero rightImage:@"pw_eyeShow" rImageframe:CGRectMake(0, 0, 50, 30) selImage:@"pw_eyeClose" target:self imageAction:@selector(buttonClick:) addView:basePwView];
    
    confirmBtn_ = [PublicView ButtonFrame:CGRectMake(15, kAddH(baseNewPwView) + 40, kScreen_Width - 30, 42) imageName:nil selImageName:nil title:@"确定" titleColor:KColorFFFFFF selTitle:nil selColor:nil target:self action:@selector(buttonClick:) addView:self.view];
    confirmBtn_.titleLabel.font = KFONT18;
    confirmBtn_.backgroundColor = KHexColor(@"#F83E44");
    [PublicView layerBorderWidth:0 borderColor:nil cornerRadius:4 addView:confirmBtn_];
    
    [pwTf_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(basePwView).offset(15);
        make.top.bottom.equalTo(basePwView);
        make.right.equalTo(basePwView).offset(-15);
    }];
    [newPwTf_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseNewPwView).offset(15);
        make.top.bottom.equalTo(baseNewPwView);
        make.right.equalTo(baseNewPwView).offset(-15);
    }];
}

- (void)usersetNewPasswordReq {
    UsersetNewPasswordReq *req = [[UsersetNewPasswordReq alloc] init];
    req.phoneNumber = self.phoneStr;
    req.enewPwd = newPwTf_.text;
    [self sendReq:req hudTit:nil isShowHud:YES failTit:nil isShowFail:YES isReceive:YES success:^(Baseres *res) {
        if ([res isKindOfClass: [UsersetNewPasswordRes class]]) {
            [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - -3] animated:YES];
        }
    } fail:nil];
}

- (BOOL)checkInput {
    BOOL isvalid = YES;
    if (!pwTf_.text.length) {
        isvalid = NO;
        [self showHudText:@"请输入新密码"];
    } else if (!newPwTf_.text.length) {
        isvalid = NO;
        [self showHudText:@"请确认新密码"];
    } else if (![pwTf_.text isEqualToString:newPwTf_.text]) {
        isvalid = NO;
        [self showHudText:@"新密码输入不一致，请重新输入。"];
    }
    return isvalid;
}

- (void)buttonClick:(id)sender {
    if (sender == confirmBtn_) {
        if ([self checkInput]) {
            [self usersetNewPasswordReq];
        }
    } else if (newPwTf_.rightView == sender) {
        UIButton *button = sender;
        button.selected = !button.selected;
        newPwTf_.secureTextEntry = !newPwTf_.secureTextEntry;
    } else if (pwTf_.rightView == sender) {
        UIButton *button = sender;
        button.selected = !button.selected;
        pwTf_.secureTextEntry = !pwTf_.secureTextEntry;
    }
}

@end
