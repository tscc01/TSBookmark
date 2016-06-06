//
//  BookListDataModel.h
//  TSBookmark
//
//  Created by 李晓春 on 16/6/3.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocalBookInfoDataModel.h"

@interface BookListDataModel : NSObject

+ (instancetype)sharedInstance;
@property (strong, nonatomic) NSMutableArray *arrayBooks;

- (void)resetInfo;

- (BOOL)addBookInfo:(NSDictionary*)dicInfo;
- (BookInfo*)getBookInfo:(NSString*)strIsbn;

@end
