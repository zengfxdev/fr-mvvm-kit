//
//  FRApiAppConfig.m
//  FRNetworkingWithRACKit
//
//  Created by 曾凡旭 on 2017/5/10.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import "FRApiAppConfig.h"

@implementation FRApiAppConfig

+(FRApiAppConfig *)sharedConfig{
    static FRApiAppConfig *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FRApiAppConfig alloc] init];
    });
    return instance;
}

-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(NSString *)defaultHeadAuth{
    // 这里自定义认证头
    return @"";
}

-(AFSecurityPolicy *)securityPolicy{
    return [AFSecurityPolicy defaultPolicy];
}

@end
