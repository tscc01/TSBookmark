//
//  MyTableViewCell.m
//  TSBookmark
//
//  Created by 李晓春 on 16/5/31.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "MyTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _labelTitle.numberOfLines = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)height
{
    return 100;
}

- (void)setDicInfo:(NSDictionary *)dicInfo
{
    [_imgBook sd_setImageWithURL:dicInfo[@"ImageUrl"]];
    _labelTitle.text = dicInfo[@"Title"];
}

@end
