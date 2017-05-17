//
//  FRApiServerProtocol.m
//  FRNetworkingWithRACKit
//
//  Created by 曾凡旭 on 2017/5/10.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FRApiServerProtocol <NSObject>

/**
 *  @brief  当前API域名
 */
@property (nullable, nonatomic, copy, readonly) NSString *serverUrl;

/**
 *  @brief  设置API域名
 */
-(void)setServerUrl:(NSString *_Nullable)serverUrl;

@end
