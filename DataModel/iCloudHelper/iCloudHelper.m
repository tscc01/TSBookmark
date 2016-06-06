//
//  iCloudHelper.m
//  TSBookmark
//
//  Created by 李晓春 on 16/6/2.
//  Copyright © 2016年 tscc-sola. All rights reserved.
//

#import "iCloudHelper.h"
#import <iCloudDocumentSync/iCloud.h>
#import "STUtilities.h"
#import "TagListDataModel.h"
#import "BookListDataModel.h"
#import <NSDate-Extensions/NSDate-Utilities.h>
#import <CloudKit/CloudKit.h>
#import "SplashViewController.h"

NSString *ICLOUD_OPEN = @"ICLOUD_OPEN";
NSString *ICLOUD_DATE = @"ICLOUD_DATE";


@interface iCloudHelper () <iCloudDelegate>

@property (weak, nonatomic) SplashViewController *vcSplash;

@end

@implementation iCloudHelper

+ (instancetype)sharedInstance {
    static iCloudHelper* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [iCloudHelper new];
    });
    
    return instance;
}

- (void)initHelper
{
    [[iCloud sharedCloud] setDelegate:self]; // Set this if you plan to use the delegate
    [[iCloud sharedCloud] setVerboseLogging:YES];
    
    [[iCloud sharedCloud] setupiCloudDocumentSyncWithUbiquityContainer:nil];

    BOOL cloudIsAvailable = [[iCloud sharedCloud] checkCloudAvailability];
    if (cloudIsAvailable) {
        if ([self isICloudOpen]) {
            if ([iCloud sharedCloud].listCloudFiles.count == 0) {
                [self finishSynchronize];
            }
            else {
                [self updateFile];
            }
        }
        else {
            [self finishSynchronize];
        }
    }
    else {
        [self finishSynchronize];
    }
}

- (void)finishSynchronize
{
    if (!_vcSplash) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [BookListDataModel sharedInstance];
        [TagListDataModel sharedInstance];
        
        [_vcSplash showContentViewController];
    });
}

- (BOOL)isICloudOpen
{
    if (![[PersistentHelper sharedInstance]getNumberForKey:ICLOUD_OPEN]) {
        return YES;
    }
    
    return [[[PersistentHelper sharedInstance]getNumberForKey:ICLOUD_OPEN]boolValue];
}

- (void)setICloudOpen:(BOOL)bOpen;
{
    [[PersistentHelper sharedInstance]saveNumber:[NSNumber numberWithBool:bOpen] forKey:ICLOUD_OPEN];
}

- (void)updateFile
{
    [[iCloud sharedCloud] updateFiles];
}

- (void)setSplash:(id)vcSplash
{
    _vcSplash = vcSplash;
    [self initHelper];
}

- (void)synchronize
{
    CKRecordID *recordID = [[CKRecordID alloc] initWithRecordName:@"LKDBHelper"];
    CKRecord *record = [[CKRecord alloc] initWithRecordType:@"LKDBHelper" recordID:recordID];
    record[@"recordId"] = [NSDate date];
    CKContainer *myContainer = [CKContainer defaultContainer];
    CKDatabase *publicDatabase = [myContainer publicCloudDatabase];
    
    [publicDatabase saveRecord:record completionHandler:^(CKRecord *artworkRecord, NSError *error){
        if (!error) {
            // Insert successfully saved record code
            [[PersistentHelper sharedInstance]saveDate:record[@"recordId"] forKey:ICLOUD_DATE];
            
            NSString* dbpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LKDB/LKDB.db"];
            NSData *data = [NSData dataWithContentsOfFile:dbpath];
            
            [[iCloud sharedCloud] saveAndCloseDocumentWithName:@"LKDB.db" withContent:data completion:^(UIDocument *cloudDocument, NSData *documentData, NSError *error) {
                if (error == nil) {
                    // Code here to use the UIDocument or NSData objects which have been passed with the completion handler
                }
            }];
        }
        else {
            // Insert error handling
            if (error.code == 14) {
                [publicDatabase deleteRecordWithID:recordID completionHandler:^(CKRecordID * _Nullable recordID, NSError * _Nullable error) {
                    [self synchronize];
                }];
            }
        }
    }];
}


- (void)iCloudFilesDidChange:(NSMutableArray *)files withNewFileNames:(NSMutableArray *)fileNames
{
    CKDatabase *publicDatabase = [[CKContainer defaultContainer] publicCloudDatabase];
    CKRecordID *artworkRecordID = [[CKRecordID alloc] initWithRecordName:@"LKDBHelper"];
    [publicDatabase fetchRecordWithID:artworkRecordID completionHandler:^(CKRecord *artworkRecord, NSError *error) {
        if (error) {
            // Error handling for failed fetch from public database
            [self finishSynchronize];
        }
        else {
            // Display the fetched record
            NSDate *dateICloud = artworkRecord[@"recordId"];
            NSDate *dateLocal = [[PersistentHelper sharedInstance]getDateForKey:ICLOUD_DATE];
            
            if (!dateLocal || (![dateICloud isEqualToDate:dateICloud] && [dateICloud isLaterThanDate:dateLocal])) {
                [[iCloud sharedCloud] retrieveCloudDocumentWithName:@"LKDB.db" completion:^(UIDocument *cloudDocument, NSData *documentData, NSError *error) {
                    if (!error) {
                        NSString* dbpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/LKDB/LKDB.db"];
                        NSData *fileData = documentData;
                        
                        [[NSFileManager defaultManager]createDirectoryAtPath:[dbpath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
                        [[NSFileManager defaultManager]createFileAtPath:dbpath contents:fileData attributes:nil];
                        [self finishSynchronize];
                    }
                    
                }];
            }
            else {
                [self finishSynchronize];
            }
        }
    }];
}

@end
