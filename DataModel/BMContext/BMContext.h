//
//  BMContext.h
//  TSBookmark
//
//  Created by 李晓春 on 16/5/30.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainTabBarController.h"

@interface BMContext : NSObject

+ (instancetype)sharedInstance;

@property (strong, nonatomic) NSMutableDictionary *dicUserInfo;
@property (strong, nonatomic) MainTabBarController *vcMain;

@end
