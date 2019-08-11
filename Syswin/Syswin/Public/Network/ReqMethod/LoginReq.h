//
//  LoginReq.h
//  FYD_live
//
//  Created by mac on 2018/1/15.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

///登录：获取验证码
@interface UsergetLoginVerificationCodeReq : Basereq

@property (nonatomic,copy) NSString *phoneNumber;

@end

@interface UsergetLoginVerificationCodeRes : Baseres

@property (nonatomic,copy)  NSString *checkCode;   //识别码

@end


///登录
@interface UserloginReq : Basereq

@property (nonatomic,copy) NSString *phoneNumber;       //手机号码
@property (nonatomic,copy) NSString *loginType;         //登录类型
@property (nonatomic,copy) NSString *password;          //登录密码
@property (nonatomic,copy) NSString *checkCode;         //识别码
@property (nonatomic,copy) NSString *randomCode;        //短信验证码

@end

@interface UserloginRes : Baseres

@end


///注册：获取验证码
@interface UsergetRegVerificationCodeReq : Basereq

@property (nonatomic,copy) NSString *phoneNumber;

@end

@interface UsergetRegVerificationCodeRes : Baseres

@property (nonatomic,copy)  NSString *checkCode;   //识别码

@end


///注册
@interface UserregReq : Basereq

@property (nonatomic,copy) NSString *phoneNumber;           //手机号码
@property (nonatomic,copy) NSString *checkCode;             //识别码
@property (nonatomic,copy) NSString *randomCode;            //短信验证码
@property (nonatomic,copy) NSString *password;              //登录密码
@property (nonatomic,copy) NSString *salesmanAccount;       //业务员账号

@end

@interface UserregRes : Baseres

@end


///登出
@interface UserlogoutReq : Basereq

@end

@interface UserlogoutRes : Baseres


@end

///修改登录密码
@interface UserchangePasswordReq : Basereq

@property (nonatomic,copy) NSString *oldPwd;
@property (nonatomic,copy) NSString *enewPwd;

@end

@interface UserchangePasswordRes : Baseres

@end

///修改手机号-获取验证码
@interface UsergetChangePhoneVerificationCodeReq : Basereq

@property (nonatomic,copy) NSString *phoneNumber;

@end

@interface UsergetChangePhoneVerificationCodeRes : Baseres

@property (nonatomic,copy) NSString *checkCode;

@end

///修改手机号-校验旧手机验证码
@interface UsercheckOldPhoneVerificationCodeReq : Basereq

@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy) NSString *checkCode;
@property (nonatomic,copy) NSString *randomCode;

@end

@interface UsercheckOldPhoneVerificationCodeRes : Baseres

@end

///修改手机号-身份验证
@interface UsercheckIdNumberReq : Basereq

@property (nonatomic,copy) NSString *realName;
@property (nonatomic,copy) NSString *idCardNo;

@end

@interface UsercheckIdNumberRes : Baseres

@end

///修改手机号-绑定新手机号
@interface UsercheckNewPhoneVerificationCodeReq : Basereq

@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy) NSString *checkCode;
@property (nonatomic,copy) NSString *randomCode;

@end

@interface UsercheckNewPhoneVerificationCodeRes : Baseres

@end

///忘记密码-获取验证码
@interface UsergetForgetPasswordVerificationCodeReq : Basereq

@property (nonatomic,copy) NSString *phoneNumber;

@end

@interface UsergetForgetPasswordVerificationCodeRes : Baseres

@property (nonatomic,copy) NSString *checkCode;

@end

///忘记密码-校验手机验证码
@interface UsercheckVerificationCodeReq : Basereq

@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy) NSString *checkCode;
@property (nonatomic,copy) NSString *randomCode;

@end

@interface UsercheckVerificationCodeRes : Baseres

@end

///忘记密码-设置新密码
@interface UsersetNewPasswordReq : Basereq

@property (nonatomic,copy) NSString *phoneNumber;
@property (nonatomic,copy) NSString *enewPwd;

@end

@interface UsersetNewPasswordRes : Baseres

@end



//wechat

@interface App_WeChat_GetBindingReq : Basereq

@property (nonatomic,copy) NSString *OpenID;

@end

@interface App_WeChat_GetBindingRes : Baseres

@end
