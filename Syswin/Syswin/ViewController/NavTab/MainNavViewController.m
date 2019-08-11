//
//  MainNavViewController.m
//  qhwy
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 qhwy. All rights reserved.
//

#import "MainNavViewController.h"

@interface MainNavViewController ()

@end

@implementation MainNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = NO; //取消背景的透明效果
    self.navigationBar.tintColor = KColor333333;
//    self.navigationBar.barTintColor = KColorFFFFFF;
    self.navigationBar.backIndicatorImage = self.navigationBar.backIndicatorTransitionMaskImage = KImage(@"back");
    NSDictionary *dic = @{NSFontAttributeName:KFONT18};
    self.navigationBar.titleTextAttributes = dic;
}

- (void)backClick:(id)sender {
    [self popViewControllerAnimated:YES];
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
