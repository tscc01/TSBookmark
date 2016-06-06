//
//  MJNetworkDataModel+Resource.h
//  minjian
//
//  Created by 李晓春 on 16/4/19.
//  Copyright © 2016年 forfunnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMNetworkDataModel.h"

@interface BMNetworkDataModel (Resource)

- (void)getBookInfo:(NSString*)strIsbn withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


@end
