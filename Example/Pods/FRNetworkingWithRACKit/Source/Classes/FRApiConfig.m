//
//  FRApiConfig.m
//  FRNetworkingWithRACKit
//
//  Created by 曾凡旭 on 2017/5/10.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import "FRApiConfig.h"

@interface FRApiConfig()

@end

@implementation FRApiConfig

@synthesize serverUrl = _serverUrl;

@synthesize defaultHeadAuth = _defaultHeadAuth;
@synthesize requestTimeoutInterval = _requestTimeoutInterval;
@synthesize securityPolicy = _securityPolicy;
@synthesize sessionConfiguration = _sessionConfiguration;

-(id)init{
    self = [super init];
    if(self){
        // 默认超时设置:30秒
        _requestTimeoutInterval = 30;
    }
    return self;
}

#pragma mark - getter && setter
-(void)setServerUrl:(NSString *)serverUrl{
    _serverUrl = serverUrl;
}

-(NSString *)serverUrl{
    return _serverUrl;
}

-(void)setDefaultHeadAuth:(NSString *)defaultHeadAuth{
    _defaultHeadAuth = defaultHeadAuth;
}

-(NSString *)defaultHeadAuth{
    return _defaultHeadAuth;
}

-(void)setRequestTimeoutInterval:(NSTimeInterval)requestTimeoutInterval{
    _requestTimeoutInterval = requestTimeoutInterval;
}

-(NSTimeInterval)requestTimeoutInterval{
    return _requestTimeoutInterval;
}

-(void)setSessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration{
    _sessionConfiguration = sessionConfiguration;
}

-(NSURLSessionConfiguration *)sessionConfiguration{
    return _sessionConfiguration;
}

@end
