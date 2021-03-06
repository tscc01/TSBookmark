//
//  InitializationManager.h
//  HaoYa
//
//  Created by 李晓春 on 15/4/9.
//  Copyright (c) 2015年 HaoYa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InitializationManager : NSObject

+ (instancetype)sharedInstance;

- (void)initSystemComponentsWithOptions:(NSDictionary *)launchOptions;
- (void)registerRemoteNotification;

@end
