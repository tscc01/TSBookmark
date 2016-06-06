//
//  AddBookRecordViewConroller.m
//  TSBookmark
//
//  Created by 李晓春 on 16/6/3.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "AddBookRecordViewConroller.h"
#import "LocalBookInfoDataModel.h"
#import "ImageDetailViewController.h"

@interface AddBookRecordViewConroller () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcImageWidth;
@property (weak, nonatomic) IBOutlet UITextField *textPage;
@property (weak, nonatomic) IBOutlet UIImageView *imgMark;
@property (weak, nonatomic) IBOutlet UITextView *textMark;

@end

@implementation AddBookRecordViewConroller

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
    [self initViews];
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

- (BOOL)isInputValid
{
    if (!_textPage.text.length && !_imgMark.image && !_textMark.text.length) {
        return NO;
    }
    return YES;
}

- (void)initViews
{
    NSString* title = @"保存";
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:self action:@selector(rightBarButtonAction:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton animated:YES];
}

- (void)rightBarButtonAction:(id)sender
{
    if (![self isInputValid]) {
        [[[UIAlertView alloc]initWithTitle:@"您还没有添加任何笔记" message:@"请添加后进行保存" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        return;
    }
    
    BookMark *mark = [BookMark new];
    
    mark.pageNumber = _textPage.text;
    mark.image = _imgMark.image;
    mark.isbn = _strIsbn;
    mark.mark = _textMark.text;
    
    [mark saveToDB];
    
    BookInfo *info = [BookInfo searchSingleWithWhere:@{@"isbn":mark.isbn} orderBy:nil];
    info.date = [NSDate date];
    [info saveToDB];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onButtonPhotoClicked:(id)sender {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    UIImagePickerController* controller = [UIImagePickerController new];
    controller.allowsEditing = YES;
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    [self presentViewController:controller animated:YES completion:nil];
}

- (NSString*)createTempfile:(UIImage*)image
{
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    image = [self imageWithImage:image scaledToSize:size];
    NSString *fileName = [NSString stringWithFormat:@"%@%@", [[NSProcessInfo processInfo] globallyUniqueString], @".png"];
    NSString *strFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    NSError *error = nil;
    [UIImageJPEGRepresentation(image, 0.5) writeToFile:strFilePath options:NSDataWritingAtomic error:&error];
    return strFilePath;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (IBAction)onImgTapped:(id)sender {
    if (!_imgMark.image) {
        return;
    }
    
    ImageDetailViewController *viewController = [[ImageDetailViewController alloc]initWithNibName:nil bundle:nil];
    viewController.imageMain = _imgMark.image;
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if (info[@"UIImagePickerControllerEditedImage"]) {
        UIImage *image = info[@"UIImagePickerControllerEditedImage"];
        NSString *strFilePath = [self createTempfile:image];
        _imgMark.image = [UIImage imageWithContentsOfFile:strFilePath];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
