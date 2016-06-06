//
//  ECNetworkDataModel.h
//  ECarDriver
//
//  Created by sola on 15/8/18.
//  Copyright (c) 2015年 upluscar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

extern const NSString* ECSTATICURLADDRESS;

@interface BMNetworkDataModel : NSObject

+ (instancetype)sharedInstance;

- (void)helloWorldWithSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)simplePost:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)simpleGet:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)simplePut:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)simpleDelete:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)simpleUploadPre:(NSString*)URLString parameters:(NSDictionary*)dicParams data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)simpleUpload:(NSString *)URLString parameters:(NSDictionary*)dicParams data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)post:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)get:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)put:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)delete:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)uploadPre:(NSString*)URLString parameters:(NSDictionary*)dicParams data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)upload:(NSString *)URLString parameters:(NSDictionary*)dicParams data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)userPost:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)userGet:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)userPut:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)userDelete:(NSString *)URLString parameters:(NSDictionary*)dicParams withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)userUploadPre:(NSString*)URLString parameters:(NSDictionary*)dicParams data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType withSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)userUpload:(NSString *)URLString parameters:(NSDictionary*)dicParams data:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType withSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSString*)getApiServerUrl:(NSString*)strService;

- (void)showCommonAlertViewWithError:(NSError*)error title:(NSString*)strTitle;

- (NSString *)url:(NSString *)baseUrl withDictionary:(NSDictionary *)dictionary;

@end
