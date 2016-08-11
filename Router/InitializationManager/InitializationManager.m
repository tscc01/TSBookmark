//
//  InitializationManager.m
//  TengNiu
//
//  Created by 李晓春 on 15/4/9.
//  Copyright (c) 2015年 Teng Niu. All rights reserved.
//

#import "InitializationManager.h"
#import "ConstantVariables.h"
#import "BookListDataModel.h"
#import "TagListDataModel.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <UIKit/UIKit.h>
#import "STUtilities.h"
#import "iCloudHelper.h"
#import <STSafeCategory/STSafeCategory.h>


@interface InitializationManager ()

@end

@implementation InitializationManager

+ (instancetype)sharedInstance {
    static InitializationManager* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [InitializationManager new];
    });
    
    return instance;
}

- (void)initSystemComponentsWithOptions:(NSDictionary *)launchOptions
{    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] disableInViewControllerClass:[UIAlertView class]];
    
    [UIViewController replaceBackButton];
    
    [iCloudHelper sharedInstance];
    
    [[STSafeCategory sharedInstance]enableSafeCategory];
}


- (void)registerRemoteNotification {
    
}

@end
