//
//  BMBookInfoHelper.h
//  TSBookmark
//
//  Created by 李晓春 on 16/5/31.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BMBookInfoHelperDelegate <NSObject>
@optional

- (void)dataHasBeenReached:(NSDictionary*)dicInfo isbn:(NSString*)strIsbn;
- (void)requestFailed:(NSError*)error;

@end
@interface BMBookInfoHelper : NSObject

@property (nonatomic, weak) id<BMBookInfoHelperDelegate> delegate;

- (void)requestBookInfo:(NSString*)strBookIsbn;

@end
