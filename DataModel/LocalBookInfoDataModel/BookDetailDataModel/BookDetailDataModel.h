//
//  BookDetailDataModel.h
//  TSBookmark
//
//  Created by 李晓春 on 16/6/3.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalBookInfoDataModel.h"

@interface BookDetailDataModel : NSObject

@property (strong, nonatomic) BookInfo *bookInfo;
@property (strong, nonatomic) NSMutableDictionary *dicDetail;

- (void)addBookMark:(NSDictionary*)dicInfo;

@end
