//
//  SplashFailedView.h
//  HaoYa
//
//  Created by 李晓春 on 15/4/16.
//  Copyright (c) 2015年 HaoYa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SplashView.h"

@interface SplashFailedView : UIView

- (void)setFailedState:(NSError*)dicInfo;

@property (nonatomic, weak) id<SplashFailedViewDelegate> delegate;

@end
