//
//  TagListDataModel.h
//  TSBookmark
//
//  Created by 李晓春 on 16/6/3.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagListDataModel : NSObject

+ (instancetype)sharedInstance;
@property (strong, nonatomic) NSMutableArray *arrayTags;
- (void)resetInfo;

- (void)addTagInfo:(NSDictionary*)dicInfo;

@end
