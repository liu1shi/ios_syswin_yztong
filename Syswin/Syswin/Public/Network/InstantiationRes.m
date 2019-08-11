//
//  InstantiationRes.m
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "InstantiationRes.h"

@implementation InstantiationRes

+ (Baseres *)ETS_InstantiationBaseResWithMainfun:(MAIN_FUNC_TYPE)mainfun{
    
// LoginReq.h
    switch (mainfun) {
        case E_UsergetLoginVerificationCode:
            return [[UsergetLoginVerificationCodeRes alloc] init];
            break;
        case E_Userlogin:
            return [[UserloginRes alloc] init];
            break;
        case E_UsergetRegVerificationCode:
            return [[UsergetRegVerificationCodeRes alloc] init];
            break;
        case E_Userreg:
            return [[UserregRes alloc] init];
            break;
        case E_Userlogout:
            return [[UserloginRes alloc] init];
            break;
        case E_UserchangePassword:
            return [[UserchangePasswordRes alloc] init];
            break;
        case E_UsergetChangePhoneVerificationCode:
            return [[UsergetChangePhoneVerificationCodeRes alloc] init];
            break;
        case E_UsercheckOldPhoneVerificationCode:
            return [[UsercheckOldPhoneVerificationCodeRes alloc] init];
            break;
        case E_UsercheckIdNumber:
            return [[UsercheckIdNumberRes alloc] init];
            break;
        case E_UsercheckNewPhoneVerificationCode:
            return [[UsercheckNewPhoneVerificationCodeRes alloc] init];
            break;
        case E_UsergetForgetPasswordVerificationCode:
            return [[UsergetForgetPasswordVerificationCodeRes alloc] init];
            break;
        case E_UsercheckVerificationCode:
            return [[UsercheckVerificationCodeRes alloc] init];
            break;
        case E_UsersetNewPassword:
            return [[UsersetNewPasswordRes alloc] init];
            break;
        case App_WeChat_GetBinding:
            return [[App_WeChat_GetBindingRes alloc] init];
            break;
    }
    return nil;
}






@end
