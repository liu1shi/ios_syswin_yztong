//
//  Public_UserDefault.h
//  FYD
//
//  Created by mac on 2017/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "singleton.h"


@interface Public_UserDefault : NSObject

single_interface(Public_UserDefault)

@property (nonatomic,assign)  BOOL isFirstAPP;                 //是否第一次进入App，判断为空则是
@property (nonatomic,assign)  BOOL isJumpAd;                   //是否进入启动页
@property (nonatomic,assign)  BOOL isLogin;                     //是否登录
@property (nonatomic,copy)  NSString *usernameStr;
@property (nonatomic,copy)  NSString *phoneStr;                    //手机号
@property (nonatomic,copy)  NSString *cookieStr;                   //存cookie

@end
