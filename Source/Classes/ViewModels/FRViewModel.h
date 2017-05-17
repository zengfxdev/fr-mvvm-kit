//
//  FRViewModel.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RVMViewModel.h"
#import "FRViewModelProtocol.h"

@interface FRViewModel : RVMViewModel<FRViewModelProtocol>

/**
 *  @brief 禁用无关构造函数
 */
+ (instancetype) new NS_UNAVAILABLE;

@end
