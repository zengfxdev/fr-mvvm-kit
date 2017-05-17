//
//  FRApiClient.m
//  FRNetworkingWithRACKit
//
//  Created by 曾凡旭 on 2017/5/10.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import "FRApiClient.h"

@interface FRApiClient()

@property (nonatomic, strong, readwrite) AFHTTPSessionManager *sessionManager;

@property (nonatomic, strong) NSMutableURLRequest *request;

@end

@implementation FRApiClient

#pragma mark - life cycle

- (instancetype)init {
    return [self initWithConfig:nil];
}

- (instancetype)initWithConfig:(nullable NSObject<FRApiServerProtocol,FRNetConfigProtocol> *)config
{
    self = [super init];
    if (self) {
        _config = config;
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.URLCache = nil;
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:configuration];
        
        _sessionManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
        // 设置https
        _sessionManager.securityPolicy = _config.securityPolicy;
        // 设置超时
        _sessionManager.requestSerializer.timeoutInterval = _config.requestTimeoutInterval;
    }
    return self;
}

#pragma mark - public methods

- (RACSignal *)rac_GET:(NSString *)path parameters:(nullable id)parameters {
    return [[self rac_requestPath:path parameters:parameters method:@"GET"]
            setNameWithFormat:@"%@ -rac_GET: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_HEAD:(NSString *)path parameters:(nullable id)parameters {
    return [[self rac_requestPath:path parameters:parameters method:@"HEAD"]
            setNameWithFormat:@"%@ -rac_HEAD: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_POST:(NSString *)path parameters:(nullable id)parameters {
    return [[self rac_requestPath:path parameters:parameters method:@"POST"]
            setNameWithFormat:@"%@ -rac_POST: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_POST:(NSString *)path
             parameters:(nullable id)parameters
constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block {
    @weakify(self);
    return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        @strongify(self);
        self.request = [self.sessionManager.requestSerializer
                        multipartFormRequestWithMethod:@"POST"
                        URLString:[[NSURL URLWithString:path
                                          relativeToURL:[NSURL URLWithString:self.config.serverUrl]] absoluteString]
                        parameters:parameters
                        constructingBodyWithBlock:block
                        error:nil];
        
        NSURLSessionDataTask *task = [self.sessionManager
                                      dataTaskWithRequest:self.request
                                      completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                          if (error) {
                                              [subscriber sendError:[NSError errorWithDomain:error.domain code:error.code userInfo:error.userInfo]];
                                          } else {
                                              [subscriber sendNext:RACTuplePack(responseObject, response)];
                                              [subscriber sendCompleted];
                                          }
                                      }];
        [task resume];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }] setNameWithFormat:@"%@ -rac_POST: %@, parameters: %@, constructingBodyWithBlock:", self.class, path, parameters];
}

- (RACSignal *)rac_PUT:(NSString *)path parameters:(nullable id)parameters {
    return [[self rac_requestPath:path parameters:parameters method:@"PUT"]
            setNameWithFormat:@"%@ -rac_PUT: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_PATCH:(NSString *)path parameters:(nullable id)parameters {
    return [[self rac_requestPath:path parameters:parameters method:@"PATCH"]
            setNameWithFormat:@"%@ -rac_PATCH: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_DELETE:(NSString *)path parameters:(nullable id)parameters {
    return [[self rac_requestPath:path parameters:parameters method:@"DELETE"]
            setNameWithFormat:@"%@ -rac_DELETE: %@, parameters: %@", self.class, path, parameters];
}

- (RACSignal *)rac_requestPath:(NSString *)path parameters:(nullable id)parameters method:(NSString *)method {
    @weakify(self);
    return [RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSString *urlString = nil;
        if ([path containsString:@"http"]) {
            urlString = path;
        } else {
            urlString = [[NSURL URLWithString:path relativeToURL:[NSURL URLWithString:self.config.serverUrl]] absoluteString];
        }
        self.request = [self.sessionManager.requestSerializer requestWithMethod:method
                                                                      URLString:urlString
                                                                     parameters:parameters
                                                                          error:nil];
        
        NSURLSessionDataTask *task = [self.sessionManager
                                      dataTaskWithRequest:self.request
                                      completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                          if (error) {
                                              [subscriber sendError:[NSError errorWithDomain:error.domain code:error.code userInfo:error.userInfo]];
                                          } else {
                                              [subscriber sendNext:RACTuplePack(responseObject, response)];
                                              [subscriber sendCompleted];
                                          }
                                      }];
        
        [task resume];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}


@end
