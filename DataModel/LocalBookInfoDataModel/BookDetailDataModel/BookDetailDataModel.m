//
//  BookDetailDataModel.m
//  TSBookmark
//
//  Created by 李晓春 on 16/6/3.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "BookDetailDataModel.h"

@implementation BookDetailDataModel

- (void)setBookInfo:(BookInfo *)bookInfo
{
    _bookInfo = bookInfo;
    _dicDetail = [NSMutableDictionary dictionary];
    [self initWithIsbn:bookInfo.isbn];
}

- (void)initWithIsbn:(NSString*)strIsbn
{
    if (!strIsbn) {
        return;
    }
    NSArray *array = [BookMark searchWithWhere:@{@"isbn":strIsbn} orderBy:@"date DESC" offset:0 count:0];
    _dicDetail[@"Marks"] = [array mutableCopy];
}

- (void)addBookMark:(NSDictionary*)dicInfo
{
    if (![_bookInfo.isbn isEqualToString:dicInfo[@"Isbn"]]) {
        return;
    }
    
    BookMark *mark = [BookMark new];
    mark.isbn = dicInfo[@"Isbn"];
    if (dicInfo[@"PageNumber"]) {
        mark.pageNumber = dicInfo[@"PageNumber"];
    }
    if (dicInfo[@"Image"]) {
        mark.image = dicInfo[@"Image"];
    }
    
    [mark saveToDB];
    
    [_dicDetail[@"Marks"] addObject:mark];
}

@end
