//
//  HomeBannerTableViewCell.m
//  minjian
//
//  Created by 李晓春 on 16/5/13.
//  Copyright © 2016年 forfunnet. All rights reserved.
//

#import "BannerTableViewCell.h"
@interface BannerTableViewCell ()
{
    CGFloat m_fHeight;
}

@end

@implementation BannerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)height
{
    if (m_fHeight) {
        return m_fHeight;
    }
    
    return 128;
}

- (void)setHeight:(CGFloat)height
{
    m_fHeight = height;
}

@end
