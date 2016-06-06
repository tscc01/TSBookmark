//
//  MyBookDetailViewController.m
//  TSBookmark
//
//  Created by 李晓春 on 16/6/1.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "MyBookDetailViewController.h"
#import "BookDetailDataModel.h"
#import "STUtilities.h"
#import "MyBookDetailTableViewCell.h"
#import "AddBookRecordViewConroller.h"
#import "MyBookDetailHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "BookRecordDetailViewController.h"

@interface MyBookDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayCells;
@property (strong, nonatomic) BookDetailDataModel *dataModel;
@property (strong, nonatomic) MyBookDetailHeaderView *viewHeader;

@end

@implementation MyBookDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"读书笔记";
    
    _dataModel = [BookDetailDataModel new];
    _dataModel.bookInfo = _bookInfo;
    
    [self initViews];
    [self initCells];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self resetCells];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initViews
{
    NSString* title = @"添加笔记";
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:self action:@selector(rightBarButtonAction:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton animated:YES];

    _viewHeader = [MyBookDetailHeaderView viewFromNib];
    _viewHeader.labelTitle.text = _bookInfo.title;
    if (_bookInfo.image) {
        _viewHeader.imgInfo.image = _bookInfo.image;
    }
    else {
        [_viewHeader.imgInfo sd_setImageWithURL:[NSURL URLWithString:_bookInfo.imageUrl]];
    }
}

- (void)initCells
{
    _arrayCells = [NSMutableArray array];
    
    NSArray *array = _dataModel.dicDetail[@"Marks"];
    BOOL bFirst = YES;
    for (BookMark *mark in array) {
        MyBookDetailTableViewCell *cell = [MyBookDetailTableViewCell viewFromNib];
        cell.numberPage = [NSNumber numberWithInt:[mark.pageNumber intValue]];
        if (bFirst) {
            cell.labelPage.text = [NSString stringWithFormat:@"上次阅读到第%d页", [mark.pageNumber intValue]];
            bFirst = NO;
        }
        else {
            cell.labelPage.text = [NSString stringWithFormat:@"曾经阅读到第%d页", [mark.pageNumber intValue]];
        }
        cell.imgMark.image = mark.image;
        cell.labelMark.text = mark.mark;
        
        [_arrayCells addObject:cell];
    }
    
    if (!_arrayCells.count) {
        [self st_setViewControlerLoadingFinishedWithNoneDataWithViewEdgeInstets:UIEdgeInsetsMake(150, 0, 0, 0) message:@"没有任何阅读记录\r\n快去添加吧~~"];
    }
}

- (void)resetCells
{
    _dataModel.bookInfo = _bookInfo;

    if (_arrayCells.count != [_dataModel.dicDetail[@"Marks"] count]) {
        [self initCells];
        [_tableView reloadData];
        [self st_setViewControlerLoadingSuccess];
    }
}

- (void)rightBarButtonAction:(id)sender
{
    AddBookRecordViewConroller *viewController = [[AddBookRecordViewConroller alloc]initWithNibName:nil bundle:nil];
    viewController.strIsbn = _bookInfo.isbn;
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark - UITableViewDelegate & UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayCells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _arrayCells[indexPath.row];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _viewHeader;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
    BookRecordDetailViewController *viewController = [[BookRecordDetailViewController alloc]initWithNibName:nil bundle:nil];
    viewController.mark = _dataModel.dicDetail[@"Marks"][indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
