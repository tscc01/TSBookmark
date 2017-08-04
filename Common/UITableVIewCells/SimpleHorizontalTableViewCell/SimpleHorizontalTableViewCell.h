//
//  SimpleHorizontalTableViewCell.h
//  HaoYa
//
//  Created by 李晓春 on 15/4/8.
//  Copyright (c) 2015年 HaoYa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleHorizontalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelInfo;
@property (weak, nonatomic) IBOutlet UILabel *labelValue;
@property (assign, nonatomic) CGFloat height;

@end
