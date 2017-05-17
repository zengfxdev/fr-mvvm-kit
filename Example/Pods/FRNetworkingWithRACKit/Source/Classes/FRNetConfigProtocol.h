//
//  FRNetConfigProtocol.h
//  FRNetworkingWithRACKit
//
//  Created by 曾凡旭 on 2017/5/10.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFSecurityPolicy.h>

@protocol FRNetConfigProtocol <NSObject>

/**
 *  @brief  默认的认证头
 */
@property (nonatomic,copy) NSString *defaultHeadAuth;

/**
 *  @brief  超时设置默认30秒
 */
@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval;

/**
 *  @brief  安全设置SSL
 */
@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;


@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;


@end
