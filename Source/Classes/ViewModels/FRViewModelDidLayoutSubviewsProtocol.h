//
//  FRViewModelDidLayoutSubviewsProtocol.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FRViewModelDidLayoutSubviewsProtocol <NSObject>

/**
 *  @brief YES when viewDidLayoutSubviews.
 */
@property (nonatomic, assign, getter=isDidLayoutSubviews) BOOL didLayoutSubviews;

/**
 *  @brief Triggers when viewDidLayoutSubviews equals YES.
 */
@property (nonatomic, strong, readonly) RACSignal *didLayoutSubviewsSignal;



@end
