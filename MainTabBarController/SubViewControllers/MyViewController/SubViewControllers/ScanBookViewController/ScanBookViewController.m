//
//  ScanBookViewController.m
//  TSBookmark
//
//  Created by 李晓春 on 16/6/3.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "ScanBookViewController.h"
#import <ZXingObjC/ZXingObjC.h>
#import "ScanResultViewController.h"

@interface ScanBookViewController () <ZXCaptureDelegate>
{
    BOOL m_bInSearch;
}

@property (nonatomic, strong) ZXCapture *capture;
@property (weak, nonatomic) IBOutlet UIView *viewHolder;

@end

@implementation ScanBookViewController


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
    
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    
    [self.view.layer addSublayer:self.capture.layer];
    
    _viewHolder.layer.borderWidth = 1;
    _viewHolder.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view bringSubviewToFront:_viewHolder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ScanResultViewController *viewController = [[ScanResultViewController alloc]initWithNibName:nil bundle:nil];
        viewController.strIsbn = @"9787121277139";
        [self.navigationController pushViewController:viewController animated:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.capture.delegate = self;
    [self applyOrientation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    m_bInSearch = NO;
    [_capture start];
}

- (void)dealloc {
    [self.capture.layer removeFromSuperlayer];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)applyOrientation {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    float scanRectRotation;
    float captureRotation;
    
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            captureRotation = 0;
            scanRectRotation = 90;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            captureRotation = 90;
            scanRectRotation = 180;
            break;
        case UIInterfaceOrientationLandscapeRight:
            captureRotation = 270;
            scanRectRotation = 0;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            captureRotation = 180;
            scanRectRotation = 270;
            break;
        default:
            captureRotation = 0;
            scanRectRotation = 90;
            break;
    }
    
    CGAffineTransform transform = CGAffineTransformMakeRotation((CGFloat) (captureRotation / 180 * M_PI));
    [self.capture setTransform:transform];
    [self.capture setRotation:scanRectRotation];
    self.capture.layer.frame = self.view.frame;
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    if (!result) return;
    
//    // Vibrate
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    [self.capture stop];
    
    if (m_bInSearch) {
        return;
    }
    
    m_bInSearch = YES;
    ScanResultViewController *viewController = [[ScanResultViewController alloc]initWithNibName:nil bundle:nil];
    viewController.strIsbn = result.text;
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
