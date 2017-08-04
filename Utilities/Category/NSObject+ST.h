//
//  NSObject+ST.h
//  HaoYa
//
//  Created by YangNan on 15/3/20.
//  Copyright (c) 2015年 HaoYa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ST)

+ (void)swizzleMethod:(SEL)originMethod newMethod:(SEL)newMethod;

@end
