//
//  LocalBookInfoDataModel.h
//  TSBookmark
//
//  Created by 李晓春 on 16/6/2.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LKDBHelper/LKDBHelper.h>


@interface BookInfo : NSObject

@property (strong, nonatomic) NSString* isbn;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* subTitle;
@property (strong, nonatomic) UIImage* image;
@property (strong, nonatomic) NSString* imageUrl;
@property (strong, nonatomic) NSDate* date;

@end

@interface BookTagLink : NSObject

@property (strong, nonatomic) NSString* isbn;
@property (strong, nonatomic) NSString* tag;

@end

@interface TagInfo : NSObject

@property (strong, nonatomic) NSString* tag;

@end



@interface BookMark : NSObject

@property (strong, nonatomic) NSString* isbn;
@property (strong, nonatomic) NSString* pageNumber;
@property (strong, nonatomic) UIImage* image;
@property (strong, nonatomic) NSDate* date;
@property (strong, nonatomic) NSString* mark;

@end
