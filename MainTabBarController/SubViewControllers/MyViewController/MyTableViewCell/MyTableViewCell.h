//
//  MyTableViewCell.h
//  TSBookmark
//
//  Created by 李晓春 on 16/5/31.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalBookInfoDataModel.h"

@interface MyTableViewCell : UITableViewCell

@property (strong, nonatomic) BookInfo* bookInfo;
@property (weak, nonatomic) IBOutlet UIImageView *imgBook;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end
