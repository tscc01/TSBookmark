//
//  MobApiHelper.h
//  TSBookmark
//
//  Created by 李晓春 on 16/5/30.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobApiHelper : NSObject

+ (instancetype)sharedInstance;

- (NSString*)getTableName;
- (NSString*)getKeyValueWithTable:(NSString*)strTable key:(NSString*)strKey;
- (NSString*)getValueEncodeValue:(NSString*)strValue;
- (NSString*)getValueEncodeObject:(id)object;
- (NSString*)getValueDecodeValue:(NSString*)strValue;
- (id)getObjectDecodeValue:(NSString*)strValue;

@end
