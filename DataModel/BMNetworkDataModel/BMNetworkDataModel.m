//
//  ECNetworkDataModel.m
//  ECarDriver
//
//  Created by sola on 15/8/18.
//  Copyright (c) 2015年 upluscar. All rights reserved.
//

#import "BMNetworkDataModel.h"
#import "STUtilities.h"
#import "JSONKit.h"
#import "ConstantVariables.h"

#ifdef DEBUG

#else

#endif
//NSString* BASE_SERVICE_ADDRESS = @"http://121.42.147.126:8180/";
NSString* BASE_SERVICE_ADDRESS = @"http://120.55.183.113:8180/";

enum {
    STATUS_OK = 0,
    STRATUS_TOKEN_INVALID = 1,
};

@interface BMNetworkDataModel ()

@property (nonatomic, strong) AFHTTPSessionManager* manager;

@end

@implementation BMNetworkDataModel

+ (instancetype)sharedInstance {
    static BMNetworkDataModel* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [BMNetworkDataModel new];
        [instance networkInit];
    });
    
    return instance;
}

- (void)networkInit
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    _manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    [_manager setSecurityPolicy:[self securityPolicy]];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    _manager.requestSerializer.timeoutInterval = 15;
    _manager.operationQueue.maxConcurrentOperationCount = 5;
}

- (void)helloWorldWithSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableDictionary *dicParam = [NSMutableDictionary dictionary];
    dicParam[@"city"] = @"广州";
    dicParam[@"token"] = @"5j1znBVAsnSf5xQyNQyq";
    
    [_manager GET:@"http://www.pm25.in/api/querys/station_names.json" parameters:dicParam success:success failure:failure];
}

- (void)simplePost:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [_manager POST:URLString parameters:dicParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSString* strResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        id idResponseObject = [[BasicUtility sharedInstance]changeObjectFormat:[strResponse objectFromJSONString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            success(task, idResponseObject);
        });
    } failure:failure];
}

- (void)simpleGet:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [_manager GET:URLString parameters:dicParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSString* strResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        id idResponseObject = [[BasicUtility sharedInstance]changeObjectFormat:[strResponse objectFromJSONString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            success(task, idResponseObject);
        });
    } failure:failure];
}

- (void)simplePut:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [_manager PUT:URLString parameters:dicParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSString* strResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        id idResponseObject = [[BasicUtility sharedInstance]changeObjectFormat:[strResponse objectFromJSONString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            success(task, idResponseObject);
        });
    } failure:failure];
}

- (void)simpleDelete:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [_manager DELETE:URLString parameters:dicParams success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSString* strResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        id idResponseObject = [[BasicUtility sharedInstance]changeObjectFormat:[strResponse objectFromJSONString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            success(task, idResponseObject);
        });
    } failure:failure];
}

- (void)simpleUploadPre:(NSString*)URLString parameters:(NSDictionary*)dicParams data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:URLString parameters:dicParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString* strResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        id idResponseObject = [[BasicUtility sharedInstance]changeObjectFormat:[strResponse objectFromJSONString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            success(operation, idResponseObject);
        });
    } failure:failure];
}

- (void)simpleUpload:(NSString *)URLString parameters:(NSDictionary*)dicParams data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[_manager POST:URLString parameters:dicParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSString* strResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        id idResponseObject = [[BasicUtility sharedInstance]changeObjectFormat:[strResponse objectFromJSONString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            success(task, idResponseObject);
        });
    } failure:failure]resume];
}

- (void)post:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    dicParams = [self getSignedParameters:dicParams];
    [self simplePost:URLString parameters:dicParams withSuccess:success failure:failure];
}

- (void)get:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    dicParams = [self getSignedParameters:dicParams];
    [self simpleGet:URLString parameters:dicParams withSuccess:success failure:failure];
}

- (void)put:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    dicParams = [self getSignedParameters:dicParams];
    [self simplePut:URLString parameters:dicParams withSuccess:success failure:failure];
}

- (void)delete:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    dicParams = [self getSignedParameters:dicParams];
    [self simpleDelete:URLString parameters:dicParams withSuccess:success failure:failure];
}

- (void)uploadPre:(NSString*)URLString parameters:(NSDictionary*)dicParams data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    dicParams = [self getSignedParameters:dicParams];
    [self simpleUploadPre:URLString parameters:dicParams data:data name:name fileName:fileName mimeType:mimeType withSuccess:success failure:failure];
}

- (void)upload:(NSString *)URLString parameters:(NSDictionary*)dicParams data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    dicParams = [self getSignedParameters:dicParams];
    [self simpleUpload:URLString parameters:dicParams data:data name:name fileName:fileName mimeType:mimeType withSuccess:success failure:failure];
}

- (void)userPost:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self post:URLString parameters:dicParams withSuccess:success failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (401 == [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode])
        {
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(task, error);
        });
    }];
}

- (void)userGet:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self get:URLString parameters:dicParams withSuccess:success failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (401 == [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode])
        {
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(task, error);
        });
    }];
}

- (void)userPut:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self put:URLString parameters:dicParams withSuccess:success failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (401 == [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode])
        {
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(task, error);
        });
    }];
}

- (void)userDelete:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self delete:URLString parameters:dicParams withSuccess:success failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (401 == [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode])
        {
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(task, error);
        });
    }];
}

- (void)userUploadPre:(NSString*)URLString parameters:(NSDictionary*)dicParams data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [self uploadPre:URLString parameters:dicParams data:data name:name fileName:fileName mimeType:mimeType withSuccess:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (401 == [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode])
        {
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(operation, error);
        });
    }];
}

- (void)userUpload:(NSString *)URLString parameters:(NSDictionary*)dicParams data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self upload:URLString parameters:dicParams data:data name:name fileName:fileName mimeType:mimeType withSuccess:success failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (401 == [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode])
        {
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(task, error);
        });
    }];
}

- (NSString*)getApiServerUrl:(NSString*)strService
{
    NSString *strRet = [NSString stringWithFormat:@"%@%@", BASE_SERVICE_ADDRESS, strService];
    return strRet;
}

- (NSString*)getFileApiServerUrl:(NSString*)strService
{
    NSString *strRet = [NSString stringWithFormat:@"%@/%@", BASE_SERVICE_ADDRESS, strService];
    return strRet;
}

- (void)showCommonAlertViewWithError:(NSError*)error title:(NSString*)strTitle
{
    id responseObject = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    NSString *strResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSDictionary *dicInfo = [strResponse objectFromJSONString];
    NSString *strMessage = error.localizedDescription;
    if (dicInfo[@"ResponseStatus"] && dicInfo[@"ResponseStatus"][@"Message"]) {
        strMessage = dicInfo[@"ResponseStatus"][@"Message"];
        if (!strMessage.length) {
            strMessage = error.localizedDescription;
        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:strTitle message:strMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (NSDictionary*)getSignedParameters:(NSDictionary*)dicParams
{
    NSMutableDictionary *dicRet = dicParams ? [dicParams mutableCopy] : [NSMutableDictionary dictionary];
    
    NSDictionary* dicPlist = [NSBundle mainBundle].infoDictionary;
    NSString* strLocalVersion = dicPlist[@"CFBundleShortVersionString"];
    
    dicRet[@"OS"] = [UIDevice currentDevice].model;
    dicRet[@"Version"] = strLocalVersion;
    
//    dicRet[@"uid"] = @"test001";
//    dicRet[@"osVersion"] = [UIDevice currentDevice].systemVersion;
//    dicRet[@"token"] = [MJContext sharedInstance].userInfo[@"token"];
//    dicRet[@"timestamp"] = [[[BasicUtility sharedInstance]formatterForString:@"yyyy-MM-dd HH:mm:ss"]stringFromDate:[NSDate date]];
//
//    NSArray *array = dicRet.allKeys;
//    array = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        NSString *strObj1 = obj1;
//        NSString *strObj2 = obj2;
//        return [strObj1 compare:strObj2];
//    }];
//    
//    NSString *strSign = @"";
//    if (array.count) {
//        strSign = [NSString stringWithFormat:@"%@=%@", array[0], dicRet[array[0]]];
//    }
//    
//    for (int i = 1; i < array.count; i++) {
//        strSign = [NSString stringWithFormat:@"%@&%@=%@", strSign, array[i], dicRet[array[i]]];
//    }
//    
//    strSign = [NSString stringWithFormat:@"%@%@", strSign, [TNCryptor getHttpKey]];
//    strSign = [[TNCryptor MD5:strSign]lowercaseString];
//    dicRet[@"sign"] = strSign;
//    dicRet[@"signType"] = @"MD5";
    
    return dicRet;
}

- (NSString *)url:(NSString *)baseUrl withDictionary:(NSDictionary *)dictionary {
    NSRange range = [baseUrl rangeOfString:@"?"];
    NSString* first;
    if (range.location == NSNotFound) {
        first = @"?";
    } else {
        first = @"&";
    }
    __block NSInteger i = 0;
    __block NSMutableString* url = [NSMutableString stringWithString:baseUrl];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* obj, BOOL *stop) {
        NSString* value = [obj stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if (i < 1) {
            [url appendFormat:@"%@%@=%@", first, key, value];
        } else {
            [url appendFormat:@"&%@=%@", key, value];
        }
        i++;
    }];
    
    return url;
}

- (AFSecurityPolicy*)securityPolicy
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [securityPolicy setAllowInvalidCertificates:NO];
    return securityPolicy;
    /**** SSL Pinning ****/
//    NSMutableArray *array = [NSMutableArray array];
//    NSArray *arrayPath = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Certificates" ofType:@"plist"]];
//    for (NSString *strName in arrayPath) {
//        NSString *strPath = [[NSBundle mainBundle] pathForResource:strName ofType:@"cer"];
//        NSData *certData = [NSData dataWithContentsOfFile:strPath];
//        [array addObject:certData];
//    }
//    
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    [securityPolicy setAllowInvalidCertificates:YES];
//    [securityPolicy setPinnedCertificates:array];
//    /**** SSL Pinning ****/
//    
//    return securityPolicy;
}




@end
