//
//  BMContext.m
//  TSBookmark
//
//  Created by 李晓春 on 16/5/30.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "BMContext.h"
#import "STUtilities.h"
#import "ConstantVariables.h"
#import "MobApiHelper.h"
#import "JSONKit.h"
#import <OpenUDID/OpenUDID.h>


@interface BMContext ()

@property (strong, nonatomic) NSLock* lockContext;

@end


@implementation BMContext

+ (instancetype)sharedInstance {
    static BMContext* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [BMContext new];
    });
    
    return instance;
}


//Notice:
//This function maybe not correct!
- (BOOL)isViewControllerPresented:(UIViewController*)viewController
{
    UIViewController *viewCurrent = [_vcMain selectedViewController];
    return viewCurrent != viewController;
}


@end
