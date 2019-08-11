//
//  DefineHeader.h
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//
//  公共宏

#ifndef DefineHeader_h
#define DefineHeader_h

//屏幕
#define kScreen_Bounds ([UIScreen mainScreen].bounds)
#define kScreen_Width ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Height ([UIScreen mainScreen].bounds.size.height)

//frame操作
#define kOriginX(a)     (a.frame.origin.x)
#define kOriginY(a)     (a.frame.origin.y)
#define kSizeW(a)       (a.frame.size.width)
#define kSizeH(a)       (a.frame.size.height)
#define kAddW(a)        (a.frame.origin.x + a.frame.size.width)
#define kAddH(a)        (a.frame.origin.y + a.frame.size.height)

//包含热点栏（如有）高度，标准高度为20pt，当有个人热点连接时，高度为40pt
#define kSTATUSBAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height)

#define kNavigationBarHeight    (self.navigationController.navigationBar.frame.size.height)   //导航条高度
#define kTabButtomHeight    (self.tabBarController.tabBar.frame.size.height)    //底部tab的高度


#define kBundleFile(a,b)  ([[NSBundle mainBundle] pathForResource:a ofType:b])
#define kBundleBuild ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]) //(build)
#define kBundleVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]) //(version)
#define KSystemVersion               ([UIDevice currentDevice].systemVersion)     //客户端系统版本


#define KRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define KHexColor(a)   [PublicMethod colorWithHexString:a]
#define KFONTSize(a) [UIFont systemFontOfSize:a]
#define KImage(a)    [UIImage imageNamed:a]
#define KStringFormat(a,b) ([NSString stringWithFormat:a,b])

//逐字节比较
#define kCompareGreater(a,b)              ([a compare:b options:NSLiteralSearch] == NSOrderedDescending)

//UI标准
#define KFONT10 KFONTSize(10)
#define KFONT12 KFONTSize(12)
#define KFONT14 KFONTSize(14)
#define KFONT16 KFONTSize(16)
#define KFONT17 KFONTSize(17)
#define KFONT18 KFONTSize(18)


#define KColorFFFFFF KHexColor(@"FFFFFF")               //白
#define KColor333333 KHexColor(@"333333")               //黑
#define KColor666666 KHexColor(@"666666")               //灰
#define KColor999999 KHexColor(@"999999")               //灰
#define KColorClear [UIColor clearColor]

#endif
