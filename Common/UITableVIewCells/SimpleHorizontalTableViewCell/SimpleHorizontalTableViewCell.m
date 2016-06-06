//
//  SimpleHorizontalTableViewCell.m
//  TengNiu
//
//  Created by 李晓春 on 15/4/8.
//  Copyright (c) 2015年 Teng Niu. All rights reserved.
//

#import "SimpleHorizontalTableViewCell.h"
#import "STUtilities.h"

@interface SimpleHorizontalTableViewCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcTail;

@end

@implementation SimpleHorizontalTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    if (self.accessoryType == UITableViewCellAccessoryNone) {
        _lcTail.constant = 15;
    } else {
        _lcTail.constant = 0;
    }
    
    [super layoutSubviews];
}

- (CGFloat)height
{
    if (_height) {
        return _height;
    }
    return 44;
}

@end
