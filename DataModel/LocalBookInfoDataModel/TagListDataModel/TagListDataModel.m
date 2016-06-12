//
//  TagListDataModel.m
//  TSBookmark
//
//  Created by 李晓春 on 16/6/3.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "TagListDataModel.h"
#import "LocalBookInfoDataModel.h"
#import "iCloudHelper.h"

@implementation TagListDataModel

+ (instancetype)sharedInstance {
    static TagListDataModel* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [TagListDataModel new];
        [instance initInfo];
    });
    
    return instance;
}


- (void)initInfo
{
    _arrayTags = [TagInfo searchWithWhere:nil];
}

- (void)resetInfo
{
    [self initInfo];
}

- (void)addTagInfo:(NSDictionary*)dicInfo
{
    NSArray *array = [TagInfo searchWithWhere:@{@"tag":dicInfo[@"name"]}];
    if (array.count) {
        return;
    }
    
    TagInfo *info = [TagInfo new];
    info.tag = dicInfo[@"name"];
    [info saveToDB];
    
    [_arrayTags addObject:info];
    
    [[iCloudHelper sharedInstance]synchronize];
}

@end
