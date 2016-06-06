//
//  iCloudHelper.h
//  TSBookmark
//
//  Created by 李晓春 on 16/6/2.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iCloudHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isICloudOpen;

- (void)setICloudOpen:(BOOL)bOpen;

- (void)synchronize;

- (void)setSplash:(id)vcSplash;

@end
