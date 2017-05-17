//
//  FRViewModelDidLoadViewProtocol.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FRViewModelDidLoadViewProtocol <NSObject>

/**
 *  @brief YES when viewDidLoad, NO when viewDidUnload
 */
@property (nonatomic, assign, getter=isDidLoadView) BOOL didLoadView;

/**
 *  @brief Triggers when didLoadView equals YES.
 */
@property (nonatomic, strong, readonly) RACSignal *didLoadViewSignal;

/**
 *  @brief Triggers when didLoadView equals NO.
 */
@property (nonatomic, strong, readonly) RACSignal *didUnloadViewSignal;

@end
