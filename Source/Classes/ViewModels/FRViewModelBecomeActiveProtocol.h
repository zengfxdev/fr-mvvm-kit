//
//  FRViewModelBecomeActiveProtocol.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FRViewModelBecomeActiveProtocol <NSObject>

@property (nonatomic, assign, getter=isActive) BOOL active;

@property (nonatomic, strong, readonly) RACSignal *didBecomeActiveSignal;

@property (nonatomic, strong, readonly) RACSignal *didBecomeInactiveSignal;

@end

NS_ASSUME_NONNULL_END
