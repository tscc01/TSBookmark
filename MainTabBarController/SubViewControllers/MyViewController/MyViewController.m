//
//  MyViewController.m
//  TSBookmark
//
//  Created by 李晓春 on 16/5/30.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "MyViewController.h"
#import "JSONKit.h"
#import "Base64.h"
#import "ConstantVariables.h"
#import "MobApiHelper.h"
#import "STUtilities.h"
#import "DZNSegmentedControl.h"
#import "LocalBookInfoDataModel.h"
#import "BookListDataModel.h"
#import "TagListDataModel.h"
#import "MyTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SimpleHorizontalTableViewCell.h"
#import "ScanBookViewController.h"
#import "TagDetailViewController.h"
#import "MyBookDetailViewController.h"

enum {
    SEGMENT_BOOK_LIST = 0,
    SEGMENT_TAG_LIST = 1,
};

@interface MyViewController ()

@property (strong, nonatomic) NSMutableArray *arrayCells;
@property (strong, nonatomic) NSMutableArray *arrayTagCells;
@property (strong, nonatomic) NSMutableArray *arrayTags;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet DZNSegmentedControl *segment;
@property (nonatomic, weak) UIImageView* navigationBorderView;


@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的读书列表";
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationBorderView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationBorderView.hidden = NO;
}

- (UIImageView *)navigationBorderView {
    if (!_navigationBorderView) {
        _navigationBorderView = self.navigationController.st_navigationBottomBorderView;
    }
    return _navigationBorderView;
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
    [_segment setTitle:@"阅读列表" forSegmentAtIndex:0];
    [_segment setTitle:@"标签列表" forSegmentAtIndex:1];
    [_segment setTintColor:[UIColor colorWithHexValue:@"00cc99"]];
    _segment.font = [UIFont systemFontOfSize:13];
    
    NSString* title = @"添加新书";
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:self action:@selector(rightBarButtonAction:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton animated:YES];
}

- (void)initCells
{
    _arrayCells = [NSMutableArray array];
    _arrayTagCells = [NSMutableArray array];
    _arrayTags = [NSMutableArray array];
    
    for (BookInfo *info in [BookListDataModel sharedInstance].arrayBooks) {
        MyTableViewCell *cell = [MyTableViewCell viewFromNib];
        if (info.image) {
            cell.imgBook.image = info.image;
        }
        else {
            [cell.imgBook sd_setImageWithURL:[NSURL URLWithString:info.imageUrl]];
        }
        cell.labelTitle.text = info.title;
        cell.bookInfo = info;
        [_arrayCells addObject:cell];
    }
    
    for (TagInfo *info in [TagListDataModel sharedInstance].arrayTags) {
        SimpleHorizontalTableViewCell *cell = [SimpleHorizontalTableViewCell viewFromNib];
        cell.labelInfo.text = info.tag;
        cell.labelValue.text = @"";
        [_arrayTags addObject:info];
        [_arrayTagCells addObject:cell];
    }
}

- (void)resetCells
{
    BOOL bChange = NO;
    
    if (_arrayCells.count != [BookListDataModel sharedInstance].arrayBooks.count) {
        bChange = YES;
    }
    else if (_arrayTagCells.count != [TagListDataModel sharedInstance].arrayTags.count) {
        bChange = YES;
    }
    
    if (bChange) {
        [self initCells];
        [_tableView reloadData];
    }
}

- (void)rightBarButtonAction:(id)sender {
    ScanBookViewController *viewController = [[ScanBookViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (IBAction)onSegmentChanged:(id)sender {
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
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
    switch (_segment.selectedSegmentIndex) {
        case SEGMENT_BOOK_LIST:
            return _arrayCells.count;
            break;
        case SEGMENT_TAG_LIST:
            return _arrayTagCells.count;
            break;
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_segment.selectedSegmentIndex) {
        case SEGMENT_BOOK_LIST:
            return _arrayCells[indexPath.row];
            break;
        case SEGMENT_TAG_LIST:
            return _arrayTagCells[indexPath.row];
            break;
        default:
            break;
    }
    
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
    switch (_segment.selectedSegmentIndex) {
        case SEGMENT_BOOK_LIST:
        {
            MyBookDetailViewController *viewController = [[MyBookDetailViewController alloc]initWithNibName:nil bundle:nil];
            MyTableViewCell *cell = _arrayCells[indexPath.row];
            viewController.bookInfo = cell.bookInfo;
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case SEGMENT_TAG_LIST:
        {
            TagDetailViewController *viewContorller = [[TagDetailViewController alloc]initWithNibName:nil bundle:nil];
            TagInfo *tag = _arrayTags[indexPath.row];
            viewContorller.strTag = tag.tag;
            [self.navigationController pushViewController:viewContorller animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
