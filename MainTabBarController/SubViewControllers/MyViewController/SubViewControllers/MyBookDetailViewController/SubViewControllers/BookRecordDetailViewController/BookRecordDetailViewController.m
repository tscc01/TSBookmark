//
//  BookRecordDetailViewController.m
//  TSBookmark
//
//  Created by 李晓春 on 16/6/6.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "BookRecordDetailViewController.h"
#import "ImageDetailViewController.h"

@interface BookRecordDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textPage;
@property (weak, nonatomic) IBOutlet UITextView *textMark;
@property (weak, nonatomic) IBOutlet UIImageView *imgMark;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcImageHeight;

@end

@implementation BookRecordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _textPage.text = _mark.pageNumber;
    _textMark.text =_mark.mark;
    if (_mark.image) {
        _imgMark.image = _mark.image;
    }
    else {
        _lcImageHeight.constant = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onImgTapped:(id)sender {
    ImageDetailViewController *viewController = [[ImageDetailViewController alloc]initWithNibName:nil bundle:nil];
    viewController.imageMain = _mark.image;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
