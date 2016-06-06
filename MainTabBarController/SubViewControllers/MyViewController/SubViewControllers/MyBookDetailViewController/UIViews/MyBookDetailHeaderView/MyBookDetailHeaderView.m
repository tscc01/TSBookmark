//
//  MyBookDetailHeaderView.m
//  TSBookmark
//
//  Created by 李晓春 on 16/6/6.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "MyBookDetailHeaderView.h"

@implementation MyBookDetailHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    _labelTitle.numberOfLines = 0;
}

@end
