//
//  Public_UserDefault.m
//  FYD
//
//  Created by mac on 2017/5/22.
//  Copyright © 2017年 mac. All rights reserved.
//
//  NSUserDefaults 数据存储

#import "Public_UserDefault.h"



@implementation Public_UserDefault

single_implementation(Public_UserDefault)

- (void)userDefault:(id)value key:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)objectForkey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

- (void)boolUserDefault:(BOOL)value key:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)boolForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

#pragma mark Read
///
- (void)setIsFirstAPP:(BOOL)isFirstAPP {
    [self boolUserDefault:isFirstAPP key:@"isFirstAPP"];
}

- (BOOL)isFirstAPP {
    return [self boolForKey:@"isFirstAPP"];
}

///

- (void)setIsJumpAd:(BOOL)isJumpAd {
    [self boolUserDefault:isJumpAd key:@"isJumpAd"];
}

- (BOOL)isJumpAd {
    return [self boolForKey:@"isJumpAd"];
}

///
- (void)setIsLogin:(BOOL)isLogin {
    [self boolUserDefault:isLogin key:@"isLogin"];
}

-(BOOL)isLogin {
    return [self boolForKey:@"isLogin"];
}

///
- (void)setUsernameStr:(NSString *)usernameStr {
    [self userDefault:usernameStr key:@"usernameStr"];
}

-(NSString *)usernameStr {
    return [self objectForkey:@"usernameStr"];
}


///
- (void)setPhoneStr:(NSString *)phoneStr {
    [self userDefault:phoneStr key:@"phoneStr"];
}

-(NSString *)phoneStr {
    return [self objectForkey:@"phoneStr"];
}

///
- (void)setCookieStr:(NSString *)cookieStr {
    [self userDefault:cookieStr key:@"cookieStr"];
}

- (NSString *)cookieStr {
    return [self objectForkey:@"cookieStr"];
}

@end
