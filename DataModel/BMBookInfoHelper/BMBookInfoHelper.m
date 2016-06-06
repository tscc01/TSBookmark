//
//  BMBookInfoHelper.m
//  TSBookmark
//
//  Created by 李晓春 on 16/5/31.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "BMBookInfoHelper.h"
#import "BMNetworkDataModel+Resource.h"

@implementation BMBookInfoHelper

- (void)requestBookInfo:(NSString*)strBookIsbn
{
    [[BMNetworkDataModel sharedInstance]getBookInfo:strBookIsbn withSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        if ([_delegate respondsToSelector:@selector(dataHasBeenReached: isbn:)]) {
            [_delegate dataHasBeenReached:responseObject isbn:strBookIsbn];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([_delegate respondsToSelector:@selector(requestFailed:)]) {
            [_delegate requestFailed:error];
        }
    }];
}

@end
