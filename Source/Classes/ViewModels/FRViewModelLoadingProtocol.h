//
//  FRViewModelLoadingProtocol.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FRViewModelLoadingProtocol <NSObject>
/**
 *  @brief  If YES, shows the loading view and triggers loading signal, default is NO.
 */
@property (nonatomic, assign, getter=isLoading) BOOL loading;

/**
 *  @brief  The signal of loading current view.
 *
 *  @return  loading RACSignal
 */
@property (nullable, nonatomic, strong) RACSignal *loadingSignal;

/**
 *  @brief Shows the retry view or not, default is NO,
 */
@property (nonatomic, assign) BOOL needRetryLoading;
@end
