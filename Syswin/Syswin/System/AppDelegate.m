//
//  AppDelegate.m
//  Syswin
//
//  Created by yang.liu on 2019/8/3.
//  Copyright © 2019 syswin. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "HomepageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setCatch];
    [self registWechat];
    
    return YES;
}

//uiwebview的内存警告策略
- (void)setCatch {
    int cacheSizeMemory = 1*1024*1024; // 4MB
    int cacheSizeDisk = 5*1024*1024; // 32MB
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"] ;
    [NSURLCache setSharedURLCache:sharedCache];
}

- (void)registWechat {
    //向微信注册
    [WXApi registerApp:kWechatAppId];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    HomepageViewController *homeVc = nil;
    for (UINavigationController *vc in nav.viewControllers) {
        if ([vc isKindOfClass:[HomepageViewController class]]) {
            homeVc = (HomepageViewController *)vc;
        }
    }
    
    return  [WXApi handleOpenURL:url delegate:homeVc];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
    HomepageViewController *homeVc = nil;
    for (UINavigationController *vc in nav.viewControllers) {
        if ([vc isKindOfClass:[HomepageViewController class]]) {
            homeVc = (HomepageViewController *)vc;
        }
    }
    
    return [WXApi handleOpenURL:url delegate:homeVc];
}

@end
