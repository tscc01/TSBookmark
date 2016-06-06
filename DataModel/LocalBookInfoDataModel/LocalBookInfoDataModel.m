//
//  LocalBookInfoDataModel.m
//  TSBookmark
//
//  Created by 李晓春 on 16/6/2.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "LocalBookInfoDataModel.h"
#import "Base64.h"

@implementation BookInfo

+(LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* dbpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LKDB/LKDB.db"];
        db = [[LKDBHelper alloc]initWithDBPath:dbpath];
    });
    return db;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.date = [NSDate date];
    }
    return self;
}

+(NSString *)getTableName
{
    return @"LKBookInfoTable";
}

+(NSString *)getPrimaryKey
{
    return @"isbn";
}

@end

@implementation BookTagLink

+(LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* dbpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LKDB/LKDB.db"];
        db = [[LKDBHelper alloc]initWithDBPath:dbpath];
    });
    return db;
}

+(NSString *)getTableName
{
    return @"LKBookTagLinkTable";
}

+(NSArray *)getPrimaryKeyUnionArray
{
    return @[@"isbn",@"tag"];
}

@end

@implementation TagInfo

+(LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* dbpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LKDB/LKDB.db"];
        db = [[LKDBHelper alloc]initWithDBPath:dbpath];
    });
    return db;
}

+(NSString *)getTableName
{
    return @"LKTagInfoTable";
}

+(NSString *)getPrimaryKey
{
    return @"tag";
}

@end

@implementation BookMark

+(LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* dbpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LKDB/LKDB.db"];
        db = [[LKDBHelper alloc]initWithDBPath:dbpath];
    });
    return db;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.date = [NSDate date];
    }
    return self;
}

+(NSString *)getTableName
{
    return @"LKBookMarkTable";
}

+(NSArray *)getPrimaryKeyUnionArray
{
    return @[@"isbn",@"date"];
}

@end