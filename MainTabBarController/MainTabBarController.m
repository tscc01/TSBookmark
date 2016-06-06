//
//  MainTabBarController.m
//  daocf
//
//  Created by 李晓春 on 16/2/29.
//  Copyright © 2016年 tscc_sola. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "MyViewController.h"
#import "SettingViewController.h"
#import "STUtilities.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initViewControllers];
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

- (void)initViewControllers
{
    HomeViewController *vcHome = [[HomeViewController alloc]initWithNibName:nil bundle:nil];
    vcHome.title = @"首页";
    UINavigationController *navHome = [[UINavigationController alloc]initWithRootViewController:vcHome];
    
    MyViewController *vcMy = [[MyViewController alloc]initWithNibName:nil bundle:nil];
    vcMy.title = @"我的";
    UINavigationController *navMy = [[UINavigationController alloc]initWithRootViewController:vcMy];
    
    SettingViewController *vcSetting = [[SettingViewController alloc]initWithNibName:nil bundle:nil];
    vcSetting.title = @"设置";
    UINavigationController *navSetting = [[UINavigationController alloc]initWithRootViewController:vcSetting];

    self.viewControllers = [NSMutableArray arrayWithObjects:navHome, navMy, navSetting, nil];
}

@end
