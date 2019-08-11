//
//  LoginReq.m
//  FYD_live
//
//  Created by mac on 2018/1/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "LoginReq.h"

///
@implementation UsergetLoginVerificationCodeReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_UsergetLoginVerificationCode;
        self.reqUrl = [kMainHost stringByAppendingString:@"/fydUser/user/getLoginVerificationCode/"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"phoneNumber"] = self.phoneNumber;
    return dic;
}

@end

@implementation UsergetLoginVerificationCodeRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
    self.checkCode = self.data[@"checkCode"];
}


@end

///
@implementation UserloginReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_Userlogin;
        self.reqUrl = [kMainHost stringByAppendingString:@"/fydUser/user/login/"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"phoneNumber"] = self.phoneNumber;
    dic[@"loginType"] = self.loginType;
    dic[@"password"] = self.password.length ? [PublicMethod md5:self.password] : self.password;
    dic[@"checkCode"] = self.checkCode;
    dic[@"randomCode"] = self.randomCode;
    return dic;
}

@end

@implementation UserloginRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
}


@end

///
@implementation UsergetRegVerificationCodeReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_UsergetRegVerificationCode;
        self.reqUrl = [kMainHost stringByAppendingString:@"/fydUser/user/getRegVerificationCode/"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"phoneNumber"] = self.phoneNumber;
    return dic;
}

@end

@implementation UsergetRegVerificationCodeRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
    self.checkCode = self.data[@"checkCode"];
}


@end

///
@implementation UserregReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_Userreg;
        self.reqUrl = [kMainHost stringByAppendingString:@"/fydUser/user/reg/"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
     dic[@"phoneNumber"] = self.phoneNumber;
     dic[@"checkCode"] = self.checkCode;
     dic[@"randomCode"] = self.randomCode;
     dic[@"password"] = self.password;
     dic[@"salesmanAccount"] = self.salesmanAccount;
    return dic;
}

@end

@implementation UserregRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
}


@end

///
@implementation UserlogoutReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_Userlogout;
        self.reqUrl = [kMainHost stringByAppendingString:@"/fydUser/user/logout/"];
    }
    return self;
}

@end

@implementation UserlogoutRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
}


@end

///
@implementation UserchangePasswordReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_UserchangePassword;
        self.reqUrl = [kMainHost stringByAppendingString:@"/fydUser/user/changePassword/"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"oldPwd"] = self.oldPwd;
    dic[@"newPwd"] = self.enewPwd;
    return dic;
}

@end

@implementation UserchangePasswordRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
}

@end

///
@implementation UsergetChangePhoneVerificationCodeReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_UsergetChangePhoneVerificationCode;
        self.reqUrl = [kMainHost stringByAppendingString:@"/fydUser/user/getChangePhoneVerificationCode/"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"phoneNumber"] = self.phoneNumber;
    return dic;
}

@end

@implementation UsergetChangePhoneVerificationCodeRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
    self.checkCode = self.data[@"checkCode"];
}
@end

///
@implementation UsercheckOldPhoneVerificationCodeReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_UsercheckOldPhoneVerificationCode;
        self.reqUrl = [kMainHost stringByAppendingString:@"/fydUser/user/checkOldPhoneVerificationCode/"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"phoneNumber"] = self.phoneNumber;
    dic[@"checkCode"] = self.checkCode;
    dic[@"randomCode"] = self.randomCode;
    return dic;
}

@end

@implementation UsercheckOldPhoneVerificationCodeRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
}

@end

///
@implementation UsercheckIdNumberReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_UsercheckIdNumber;
        self.reqUrl = [kMainHost stringByAppendingString:@"/fydUser/user/checkIdNumber/"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"realName"] = self.realName;
    dic[@"idCardNo"] = self.idCardNo;
    return dic;
}

@end

@implementation UsercheckIdNumberRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
}

@end

///
@implementation UsercheckNewPhoneVerificationCodeReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_UsercheckNewPhoneVerificationCode;
        self.reqUrl = [kMainHost stringByAppendingString:@"/fydUser/user/checkNewPhoneVerificationCode/"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"phoneNumber"] = self.phoneNumber;
    dic[@"checkCode"] = self.checkCode;
    dic[@"randomCode"] = self.randomCode;
    return dic;
}

@end

@implementation UsercheckNewPhoneVerificationCodeRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
}

@end

///
@implementation UsergetForgetPasswordVerificationCodeReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_UsergetForgetPasswordVerificationCode;
        self.reqUrl = [kMainHost stringByAppendingString:@"/fydUser/user/getForgetPasswordVerificationCode/"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"phoneNumber"] = self.phoneNumber;
    return dic;
}

@end

@implementation UsergetForgetPasswordVerificationCodeRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
    self.checkCode = self.data[@"checkCode"];
}

@end

///
@implementation UsercheckVerificationCodeReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_UsercheckVerificationCode;
        self.reqUrl = [kMainHost stringByAppendingString:@"/fydUser/user/checkVerificationCode/"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"phoneNumber"] = self.phoneNumber;
    dic[@"checkCode"] = self.checkCode;
    dic[@"randomCode"] = self.randomCode;
    return dic;
}

@end

@implementation UsercheckVerificationCodeRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
}

@end

///
@implementation UsersetNewPasswordReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_UsersetNewPassword;
        self.reqUrl = [kMainHost stringByAppendingString:@"/fydUser/user/setNewPassword/"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"phoneNumber"] = self.phoneNumber;
    dic[@"newPwd"] = self.enewPwd;
    return dic;
}

@end

@implementation UsersetNewPasswordRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
}

@end

///
@implementation App_WeChat_GetBindingReq

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Mainfun = E_UsersetNewPassword;
        self.reqUrl = [kMainHost stringByAppendingString:@"/App_WeChat_GetBinding"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"OpenID"] = self.OpenID;
    return dic;
}

@end

@implementation App_WeChat_GetBindingRes


- (void)unpackReceiveData:(id)res {
    [super unpackReceiveData:res];
}

@end
