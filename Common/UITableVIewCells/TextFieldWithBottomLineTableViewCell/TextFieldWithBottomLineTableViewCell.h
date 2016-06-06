//
//  TextFieldWithBottomLineTableViewCell.h
//  minjian
//
//  Created by 李晓春 on 16/5/13.
//  Copyright © 2016年 forfunnet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldWithBottomLineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelInfo;

@property (weak, nonatomic) IBOutlet UITextField *textInfo;

@property (weak, nonatomic) IBOutlet UIButton *btnSend;

- (void)setButtonTarget:(id)target action:(SEL)action;

@end
