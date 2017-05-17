//
//  FRViewToastProtocol.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FRViewToastProtocol <NSObject>

@optional

/**
 *  @brief 设置成功提示
 */
- (void)showSuccess:(NSString *_Nullable)status;

/**
 *  @brief 设置错误提示
 */
- (void)showError:(NSString *_Nullable)status;

@end
