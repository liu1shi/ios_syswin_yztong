//
//  ConnectManager.h
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

///接收请求返回的数据
typedef void(^ReqSuccess)(Baseres *res);
typedef void(^ReqFailure)(NSError *error);

@interface ConnectManager : NSObject


/// 发送请求 默认POST 其它要传Basereq请求类型
+ (void)sendWithReq:(Basereq *)parameters
           success:(ReqSuccess)success
           failure:(ReqFailure)failure;



@end
