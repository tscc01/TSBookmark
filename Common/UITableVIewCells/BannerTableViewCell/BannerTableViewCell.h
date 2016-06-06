//
//  HomeBannerTableViewCell.h
//  minjian
//
//  Created by 李晓春 on 16/5/13.
//  Copyright © 2016年 forfunnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KDCycleBannerView/KDCycleBannerView.h>

@interface BannerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet KDCycleBannerView *viewBanner;
- (void)setHeight:(CGFloat)height;


@end
