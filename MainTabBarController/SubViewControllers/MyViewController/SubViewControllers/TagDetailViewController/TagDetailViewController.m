//
//  TagDetailViewController.m
//  TSBookmark
//
//  Created by 李晓春 on 16/6/3.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "TagDetailViewController.h"
#import "STUtilities.h"
#import "LocalBookInfoDataModel.h"
#import "MyTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MyBookDetailViewController.h"
#import "Base64.h"

@interface TagDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayCells;

@end

@implementation TagDetailViewController

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
    [self initCells];
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

- (void)initCells
{
    _arrayCells = [NSMutableArray array];
    
    NSArray *array = [BookTagLink searchWithWhere:@{@"tag":_strTag}];
    for (BookTagLink *link in array) {
        BookInfo *book = [BookInfo searchSingleWithWhere:@{@"isbn":link.isbn} orderBy:nil];
        if (!book) {
            continue;
        }
        
        MyTableViewCell *cell = [MyTableViewCell viewFromNib];
        if (book.image) {
            cell.imgBook.image = book.image;
        }
        else {
            [cell.imgBook sd_setImageWithURL:[NSURL URLWithString:book.imageUrl]];
        }
        cell.labelTitle.text = book.title;
        cell.bookInfo = book;
        
        [_arrayCells addObject:cell];
    }
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
    return _arrayCells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _arrayCells[indexPath.row];
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
    
    MyBookDetailViewController *viewController = [[MyBookDetailViewController alloc]initWithNibName:nil bundle:nil];
    MyTableViewCell *cell = _arrayCells[indexPath.row];
    viewController.bookInfo = cell.bookInfo;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
