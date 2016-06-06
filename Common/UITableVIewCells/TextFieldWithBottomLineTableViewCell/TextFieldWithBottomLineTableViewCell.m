//
//  TextFieldWithBottomLineTableViewCell.m
//  minjian
//
//  Created by 李晓春 on 16/5/13.
//  Copyright © 2016年 forfunnet. All rights reserved.
//

#import "TextFieldWithBottomLineTableViewCell.h"

@interface TextFieldWithBottomLineTableViewCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcTextTail;

@end

@implementation TextFieldWithBottomLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _btnSend.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)height
{
    return 65;
}

- (void)setButtonTarget:(id)target action:(SEL)action
{
    _btnSend.hidden = NO;
    _lcTextTail.constant = 120;
    [_btnSend addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
