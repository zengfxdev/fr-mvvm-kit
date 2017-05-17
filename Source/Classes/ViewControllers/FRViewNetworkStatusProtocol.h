//
//  FRViewNetworkStatusProtocol.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FRViewNetworkStatusProtocol <NSObject>

@optional

/**
 *  @brief 网络恢复正常
 */
- (void)showNetworkNormal;

/**
 *  @brief 网络被断开
 */
- (void)showNetworkDisable;

@end
