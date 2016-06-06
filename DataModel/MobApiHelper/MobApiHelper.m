//
//  MobApiHelper.m
//  TSBookmark
//
//  Created by 李晓春 on 16/5/30.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "MobApiHelper.h"
#import "ConstantVariables.h"
#import "STUtilities.h"
#import <GZIP/GZIP.h>
#import "JSONKit.h"

@implementation MobApiHelper

+ (instancetype)sharedInstance {
    static MobApiHelper* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MobApiHelper new];
    });
    
    return instance;
}

- (NSString*)getTableName
{
    return SHARE_SDK_MOB_API_COMMON_TABLE;
}

- (NSString*)getKeyValueWithTable:(NSString*)strTable key:(NSString*)strKey
{
    NSString *strRet = [NSString stringWithFormat:@"%@_%@_%@", SHARE_SDK_MOB_API_PRODUCT_NAME, strTable, strKey];
    return [strRet urlSafeBase64EncodedString];
}

- (NSString*)getValueEncodeValue:(NSString*)strValue
{
    NSData *data = [strValue dataUsingEncoding:NSUTF8StringEncoding];
    NSData *dataZipped = [data gzippedDataWithCompressionLevel:1];
    NSString *strBase64 = [dataZipped base64EncodedString];
    NSString *strRet = [NSString stringWithFormat:@"{\"Data\":\"%@\"}", strBase64];
    return [strRet urlSafeBase64EncodedString];
}

- (NSString*)getValueEncodeObject:(id)object
{
    NSString *strValue = [object JSONString];
    return [self getValueEncodeValue:strValue];
}

- (NSString*)getValueDecodeValue:(NSString*)strValue
{
    NSDictionary *dicInfo = [strValue objectFromJSONString];
    NSData *dataZipped = [dicInfo[@"Data"] base64DecodedData];
    NSData *data = [dataZipped gunzippedData];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

- (id)getObjectDecodeValue:(NSString*)strValue
{
    NSString *strTemp = [self getValueDecodeValue:strValue];
    return [[BasicUtility sharedInstance] changeObjectFormat:[strTemp objectFromJSONString]];
}

@end
