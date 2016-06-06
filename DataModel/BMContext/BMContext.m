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

- (void)initInfo
{
    _lockContext = [NSLock new];
    
    if ([[[PersistentHelper sharedInstance]getNumberForKey:MOOKMARK_USER_HAS_LOGINED]boolValue]) {
        NSString *strUserName = [[PersistentHelper sharedInstance]getStringForKey:MOOKMARK_USER_NAME];
        [MobAPI sendRequest:[MOBAKvRequest kvGetRequest:[[MobApiHelper sharedInstance]getTableName] key:[[MobApiHelper sharedInstance] getKeyValueWithTable:@"UserInfo" key:strUserName]] onResult:^(MOBAResponse *response) {
            if (response.error)
            {
                [self clearContext];
            }
            else
            {
                NSDictionary *dicRet = response.responder;
                NSString *strValue = dicRet[@"v"];
                [self setDicUserInfo:[[BasicUtility sharedInstance] changeObjectFormat:[strValue objectFromJSONString]]];
            }
        }];
    }
    else {
        [self setDicUserInfo:nil];
    }
}

//Notice:
//This function maybe not correct!
- (BOOL)isViewControllerPresented:(UIViewController*)viewController
{
    UIViewController *viewCurrent = [_vcMain selectedViewController];
    return viewCurrent != viewController;
}

- (void)unlockSessionLock
{
    [_lockContext tryLock];
    
    [_lockContext unlock];
}

- (void)clearContext
{
    _dicUserInfo = nil;
    [[PersistentHelper sharedInstance]saveNumber:[NSNumber numberWithBool:NO] forKey:MOOKMARK_USER_HAS_LOGINED];
    _dicUserInfo = [NSMutableDictionary dictionary];
    _dicUserInfo[@"IsAnonymous"] = @"1";
    _dicUserInfo[@"UserName"] = [OpenUDID value];
    [[PersistentHelper sharedInstance]saveString:_dicUserInfo[@"UserName"] forKey:MOOKMARK_USER_NAME];
}

- (void)setDicUserInfo:(NSMutableDictionary *)dicUserInfo
{
    if (dicUserInfo) {
        _dicUserInfo = dicUserInfo;
        dicUserInfo[@"IsAnonymous"] = @"0";
        
        [[PersistentHelper sharedInstance]saveNumber:[NSNumber numberWithBool:YES] forKey:MOOKMARK_USER_HAS_LOGINED];
        if (dicUserInfo[@"UserName"]) {
            [[PersistentHelper sharedInstance]saveString:dicUserInfo[@"UserName"] forKey:MOOKMARK_USER_NAME];
        }
        else {
            dicUserInfo[@"UserName"] = [OpenUDID value];
            [[PersistentHelper sharedInstance]saveString:dicUserInfo[@"UserName"] forKey:MOOKMARK_USER_NAME];
        }
    }
    else {
        [self clearContext];
    }
}

@end
