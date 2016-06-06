//
//  SplashViewController.m
//  daocf
//
//  Created by 李晓春 on 16/2/29.
//  Copyright © 2016年 tscc_sola. All rights reserved.
//

#import "SplashViewController.h"
#import "MainTabBarController.h"
#import "iCloudHelper.h"

@interface SplashViewController ()


@end

@implementation SplashViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[iCloudHelper sharedInstance]setSplash:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showContentViewController
{
    MainTabBarController *vcContent = [[MainTabBarController alloc]initWithNibName:nil bundle:nil];
    [[UIApplication sharedApplication]delegate].window.rootViewController = vcContent;
}


@end
