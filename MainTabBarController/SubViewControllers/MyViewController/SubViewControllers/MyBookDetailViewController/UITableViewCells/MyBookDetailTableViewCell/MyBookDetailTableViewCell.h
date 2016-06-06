//
//  MyBookDetailTableViewCell.h
//  TSBookmark
//
//  Created by 李晓春 on 16/6/3.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBookDetailTableViewCell : UITableViewCell

@property (strong, nonatomic) NSNumber *numberPage;
@property (weak, nonatomic) IBOutlet UILabel *labelPage;
@property (weak, nonatomic) IBOutlet UIImageView *imgMark;
@property (weak, nonatomic) IBOutlet UILabel *labelMark;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcImageTop;

@end
