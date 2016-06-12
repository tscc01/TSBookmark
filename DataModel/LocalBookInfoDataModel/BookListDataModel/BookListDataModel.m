//
//  BookListDataModel.m
//  TSBookmark
//
//  Created by 李晓春 on 16/6/3.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "BookListDataModel.h"
#import <SDWebImage/SDWebImageManager.h>
#import "TagListDataModel.h"
#import "Base64.h"
#import "iCloudHelper.h"

@implementation BookListDataModel

+ (instancetype)sharedInstance {
    static BookListDataModel* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [BookListDataModel new];
        [instance initInfo];
    });
    
    return instance;
}

- (void)initInfo
{
    _arrayBooks = [BookInfo searchWithWhere:nil orderBy:@"date DESC" offset:0 count:0];
}

- (void)resetInfo
{
    [self initInfo];
}

- (BOOL)addBookInfo:(NSDictionary*)dicInfo
{
    NSArray *array = [BookInfo searchWithWhere:@{@"isbn":dicInfo[@"isbn13"]}];
    if (array.count) {
        return NO;
    }
    
    BookInfo *info = [BookInfo new];
    info.isbn = dicInfo[@"isbn13"];
    info.title = dicInfo[@"title"];
    info.subTitle = dicInfo[@"subtitle"];
    info.imageUrl = dicInfo[@"image"];
    [info saveToDB];
    [_arrayBooks insertObject:info atIndex:0];
    
    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:dicInfo[@"image"]] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        info.image = image;
        [info saveToDB];
    }];
    
    NSArray *arrayTags = dicInfo[@"tags"];
    for (NSDictionary *dicTag in arrayTags) {
        [[TagListDataModel sharedInstance]addTagInfo:dicTag];
        BookTagLink *link = [BookTagLink new];
        link.isbn = info.isbn;
        link.tag = dicTag[@"name"];
        [link saveToDB];
    }
    
    [[iCloudHelper sharedInstance]synchronize];
    
    return YES;
}


- (BookInfo*)getBookInfo:(NSString*)strIsbn
{
    BookInfo *info = [BookInfo searchSingleWithWhere:@{@"isbn":strIsbn} orderBy:nil];
    return info;
}


@end
