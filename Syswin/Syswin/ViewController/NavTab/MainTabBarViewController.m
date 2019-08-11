//
//  MainTabBarViewController.m
//  qhwy
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 qhwy. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MainNavViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVc];
}

- (void)initVc {
    self.tabBar.translucent = NO;   //取消背景的透明效果
    self.tabBar.tintColor = KHexColor(@"#F83E44");
    
    MainNavViewController *nav1 = self.viewControllers[0];
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:KImage(@"tabbar1_s") selectedImage:KImage(@"tabbar1_s")];
    
    MainNavViewController *nav2 = self.viewControllers[1];
    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"账户" image:KImage(@"tabbar2") selectedImage:KImage(@"tabbar2")];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
