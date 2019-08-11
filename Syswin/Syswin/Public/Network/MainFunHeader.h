//
//  MainFunHeader.h
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#ifndef MainFunHeader_h
#define MainFunHeader_h

typedef enum {
    E_Post,         //post 请求
    E_Get,          //get 请求
    E_Upload        //上传图片
} ReqType;

typedef enum {
    
    //login
    E_UsergetLoginVerificationCode,             //登录：获取验证码
    E_Userlogin,                                //登录
    E_UsergetRegVerificationCode,               //注册：获取验证码
    E_Userreg,                                  //注册
    E_Userlogout,                               //登出
    E_UserchangePassword,                       //修改登录密码
    E_UsergetChangePhoneVerificationCode,       //修改手机号-获取验证码
    E_UsercheckOldPhoneVerificationCode,        //修改手机号-校验旧手机验证码
    E_UsercheckIdNumber,                        //修改手机号-身份验证
    E_UsercheckNewPhoneVerificationCode,        //修改手机号-绑定新手机号
    E_UsergetForgetPasswordVerificationCode,    //忘记密码-获取验证码
    E_UsercheckVerificationCode,                //忘记密码-校验手机验证码
    E_UsersetNewPassword,                       //忘记密码-设置新密码
    App_WeChat_GetBinding,                      //微信注册绑定查询接口
    
} MAIN_FUNC_TYPE;

#endif 
