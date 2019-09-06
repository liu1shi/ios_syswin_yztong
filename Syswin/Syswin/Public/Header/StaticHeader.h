//
//  StaticHeader.h
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//
//  静态字符串

#ifndef StaticHeader_h
#define StaticHeader_h

///接口地址
//static NSString *const kMainHost = @"https://fydadmnew.my089.com";                //线上环境
//static NSString *const kMainHost = @"http://172.31.118.201:7080/#/tab";             //测试环境
static NSString *const kMainHost = @"http://syzf.syswinsoft.com:8188/#/tab";        //线上环境

static NSString *const kWechatAppId = @"wx66a0829983d09056";                 //微信APPID

/// jpush
//static NSString *const kJpushAppkey = @"78daca7bddb51fc1666df936";          //测试
//static NSString *const kJpushAppkey = @"de9ee32db452c4dbb739e079";          //生产
//static NSString *const kJpushChannel = @"Fyd";                          //下载渠道
//static BOOL const kApsForProduction = YES;                                  //生产证书

///js交互
static NSString *const kJsSaveImage = @"APP_LongClick";
static NSString *const kJsCamera = @"Native_Js_camera";
static NSString *const kJsWechatPay = @"App_WeChatPay";


///正则
static NSString *const kRegexSignlessInteger = @"^[1-9]\\d*$";      //正整数
static NSString *const kRegexInteger = @"\\d*";                     //纯数字
static NSString *const kRegexPassword = @"^[a-zA-Z0-9_]{8,16}$";    //验证密码
static NSString *const kRegexPhone = @"^1[34578]\\d{9}$";           //验证手机号

#endif 
