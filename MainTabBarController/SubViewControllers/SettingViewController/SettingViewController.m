//
//  SettingViewController.m
//  TSBookmark
//
//  Created by 李晓春 on 16/5/30.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "SettingViewController.h"
#import "STUtilities.h"
#import "SimpleHorizontalTableViewCell.h"
#import "SwitchTableViewCell.h"
#import "iCloudHelper.h"
#import <iCloudDocumentSync/iCloud.h>
#import <MessageUI/MFMailComposeViewController.h>


enum {
    SECTION_ICLOUD = 0,
    SECTION_MAIL = 1,
};

@interface SettingViewController () <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *dicCells;

@end

@implementation SettingViewController

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
- (void)prepareForSegue:(UIStoryboardS
 egue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initCells
{
    _dicCells = [NSMutableDictionary dictionary];
    _dicCells[@"iCloud"] = [NSMutableArray array];
    _dicCells[@"Mail"] = [NSMutableArray array];
    
    SwitchTableViewCell *cellICloud = [SwitchTableViewCell viewFromNib];
    cellICloud.labelInfo.text = @"阅读记录iCloud同步";
    cellICloud.switchValue.on = [[iCloudHelper sharedInstance]isICloudOpen];
    [cellICloud.switchValue addTarget:self action:@selector(onButtonICloudClicked:) forControlEvents:UIControlEventValueChanged];
    [_dicCells[@"iCloud"] addObject:cellICloud];
    
    SimpleHorizontalTableViewCell *cellMail = [SimpleHorizontalTableViewCell viewFromNib];
    cellMail.labelInfo.text = @"建议反馈";
    cellMail.labelValue.text = @"tscc01@163.com";
    cellMail.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [_dicCells[@"Mail"] addObject:cellMail];
}

- (void)onButtonICloudClicked:(id)sender
{
    UISwitch *switchButton = sender;
    if (switchButton.on) {
        BOOL cloudIsAvailable = [[iCloud sharedCloud] checkCloudAvailability];
        if (!cloudIsAvailable) {
            [[[UIAlertView alloc]initWithTitle:@"iCloud不可用" message:@"iCloud同步处于不可用状态，请确认您开启了iCloud功能并且已经登录。\r\n请在设置 -> iCloud中查看" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            return;
        }
        [[iCloudHelper sharedInstance]setICloudOpen:YES];
        [[iCloudHelper sharedInstance]synchronize];
    }
    else {
        [[iCloudHelper sharedInstance]setICloudOpen:NO];
    }
}



- (void)sendMail
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (![mailClass canSendMail]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"ServiceCenterMailAccountNotSet", @"") message:nil delegate:nil cancelButtonTitle:NSLocalizedString(@"global_message_ok", @"") otherButtonTitles:nil];
        [alert show];
        return;
    }
    [self displayMailPicker];
}

//调出邮件发送窗口
- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"意见反馈"];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"tscc01@163.com"];
    [mailPicker setToRecipients: toRecipients];
    
    NSString *strClientVersion = [STContext sharedInstance].applicationVersion;
    NSString *strDate = [[[BasicUtility sharedInstance]formatterForString:@"yyyy-MM-dd hh:mm:ss"]stringFromDate:[NSDate date]];
    
    NSString *emailBody = [NSString stringWithFormat:@"客户端版本：%@\r\n\r\n\r\n日期：%@\r\n", strClientVersion, strDate];
    [mailPicker setMessageBody:emailBody isHTML:NO];
    [self presentViewController:mailPicker animated:YES completion:nil];
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - UITableViewDelegate & UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dicCells.allKeys.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case SECTION_ICLOUD:
            return [_dicCells[@"iCloud"]count];
            break;
        case SECTION_MAIL:
            return [_dicCells[@"Mail"]count];
            break;
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case SECTION_ICLOUD:
            return _dicCells[@"iCloud"][indexPath.row];
            break;
        case SECTION_MAIL:
            return _dicCells[@"Mail"][indexPath.row];
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
    
    if (indexPath.section == SECTION_MAIL) {
        [self sendMail];
    }
}

@end
