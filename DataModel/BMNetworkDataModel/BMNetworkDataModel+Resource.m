//
//  MJNetworkDataModel+Resource.m
//  minjian
//
//  Created by 李晓春 on 16/4/19.
//  Copyright © 2016年 forfunnet. All rights reserved.
//

#import "BMNetworkDataModel+Resource.h"

@implementation BMNetworkDataModel (Resource)


- (void)getBookInfo:(NSString*)strIsbn withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *strUrl = [NSString stringWithFormat:@"https://api.douban.com/v2/book/isbn/%@", strIsbn];
    
    [self get:strUrl parameters:nil withSuccess:success failure:failure];
}

@end
