//
//  TNCryptor.h
//  TengNiu
//
//  Created by YangNan on 15/4/1.
//  Copyright (c) 2015年 Teng Niu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNCryptor : NSObject

+ (NSString *)MD5:(NSString *)string;
+ (NSString *)fileMD5:(NSString *)string;
+ (NSData *)dataByAES256WithString:(NSString *)string forKey:(NSString*)key;
+ (NSString *)stringByAES256WithData:(NSData *)data forKey:(NSString*)key;

//+ (NSData *)AES256EncryptData:(NSData *)data withKey:(NSString*)key;
//+ (NSData *)AES256DecryptData:(NSData *)data withKey:(NSString*)key;
@end
