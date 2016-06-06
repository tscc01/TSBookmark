//
//  MyBookDetailTableViewCell.m
//  TSBookmark
//
//  Created by 李晓春 on 16/6/3.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "MyBookDetailTableViewCell.h"

@implementation MyBookDetailTableViewCell

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
    CGFloat fRet = 15;
    
    if ([_numberPage intValue]) {
        fRet += 21;
        fRet += 15;
    }
    else {
        _labelPage.text = nil;
        _lcImageTop.constant = 0;
    }
    
    if (_imgMark.image) {
        fRet += 100;
        fRet += 15;
    }
    
    if (_labelMark.text.length) {
        fRet += 18;
        fRet += 15;
    }
    
    return fRet;
}

@end
