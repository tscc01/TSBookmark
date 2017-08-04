//
//  ConstantVariables.h
//  ST
//
//  Created by 李晓春 on 15/4/7.
//  Copyright (c) 2015年 HaoYa. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString* LAST_WIZARD_VERSION;


extern NSString* SHARE_SDK_MOB_API_APP_KEY;
extern NSString* SHARE_SDK_MOB_API_COMMON_TABLE;
extern NSString* SHARE_SDK_MOB_API_PRODUCT_NAME;

extern NSString* SHARE_SDK_SMS_APP_KEY;
extern NSString* SHARE_SDK_SMS_APP_SECRET;
extern NSString* SHARE_SDK_APP_KEY;
extern NSString* SHARE_SDK_APP_SECRET;
extern NSString* WEIBO_SDK_APP_KEY;
extern NSString* WEIBO_SDK_APP_SECRET;
extern NSString* WEIBO_SDK_REDIRECT_URL;
extern NSString* WECHAT_SDK_APP_KEY;
extern NSString* WECHAT_SDK_APP_SECRET;

extern const NSInteger USER_SUCCESS_AD_COUNT;

extern NSString* HOME_REQUEST_PULL_COUNT;

extern NSString* MOOKMARK_USER_HAS_LOGINED;
extern NSString* MOOKMARK_USER_NAME;



enum {
    PRODUCT_TIP_ORIGINAL = 0,
    PRODUCT_TIP_MANUAL = 1,
    PRODUCT_TIP_CUSTOMIZED = 2,
    PRODUCT_TIP_LIMITED = 3,
};


enum {
    MAIN_TAB_HOME = 0,
    MAIN_TAB_FIND = 1,
    MAIN_TAB_MY = 2,
    MAIN_TAB_MASTER = 3,
};
