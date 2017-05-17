//
//  FRViewModelToastProtocol.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FRViewModelToastProtocol <NSObject>

/**
 *  @brief  成功，完成
 */
@property (nonatomic, strong, readonly) RACSubject *successSubject;

/**
 *  @brief  错误
 */
@property (nonatomic, strong, readonly) RACSubject *errorSubject;

@end
