//
//  ScanResultViewController.m
//  TSBookmark
//
//  Created by 李晓春 on 16/6/3.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "ScanResultViewController.h"
#import "BMBookInfoHelper.h"
#import "STUtilities.h"
#import <Toast/UIView+Toast.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "BookListDataModel.h"
#import "MyBookDetailViewController.h"

@interface ScanResultViewController () <BMBookInfoHelperDelegate>

@property (strong, nonatomic) BMBookInfoHelper *dataModel;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgBook;
@property (strong, nonatomic) NSDictionary *dicInfo;

@end

@implementation ScanResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"查到图书";
    
    [self st_setViewControlerInLoading];
    
    _dataModel = [BMBookInfoHelper new];
    _dataModel.delegate = self;
    [_dataModel requestBookInfo:_strIsbn];
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

- (IBAction)onButtonAddClicked:(id)sender {
    BOOL bAdd = [[BookListDataModel sharedInstance]addBookInfo:_dicInfo];
    BookInfo *info = [[BookListDataModel sharedInstance]getBookInfo:_dicInfo[@"isbn13"]];
    
    NSString *strMessage = @"";
    if (bAdd) {
        strMessage = @"图书已经被添加，请添加读书记录";
    }
    else {
        strMessage = @"您已经阅读过该书，请继续添加读书记录~";
    }
    
    NSMutableArray *array = [self.navigationController.viewControllers mutableCopy];
    MyBookDetailViewController *viewController = [[MyBookDetailViewController alloc]initWithNibName:nil bundle:nil];
    viewController.bookInfo = info;
    [viewController.view makeToast:strMessage duration:3.0 position:CSToastPositionCenter];
    
    UIViewController *vcTemp = array[0];
    [array removeAllObjects];
    [array addObject:vcTemp];
    [array addObject:viewController];
    [self.navigationController setViewControllers:array animated:YES];
}

#pragma mark - BMBookInfoHelperDelegate
- (void)dataHasBeenReached:(NSDictionary*)dicInfo isbn:(NSString*)strIsbn
{
    [self st_setViewControlerLoadingSuccess];
    
    _dicInfo = dicInfo;
    
    _labelTitle.text = dicInfo[@"title"];
    [_imgBook sd_setImageWithURL:dicInfo[@"image"]];
}

- (void)requestFailed:(NSError*)error
{
    [self.navigationController.view makeToast:@"暂未查到图书信息，请重新扫描" duration:3.0 position:CSToastPositionCenter];

    [self.navigationController popViewControllerAnimated:YES];
}

@end
