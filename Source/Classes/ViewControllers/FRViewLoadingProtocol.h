//
//  FRViewLoadingProtocol.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FRViewLoadingProtocol <NSObject>

@optional

/**
 *  @brief 设置loading的contentView，会被居中显示，需设定为以下信号触发时启动动画
 ＊  [RACSignal merge:@[
 ＊    [submittingView rac_signalForSelector:@selector(didMoveToWindow)],
 ＊    [submittingView rac_signalForSelector:@selector(didMoveToSuperview)]
 ＊  ]]
 */
- (UIView *)customLoadingView:(UIView *)parentView;

- (void)hideRetryView;

- (void)showRetryView;

@end
