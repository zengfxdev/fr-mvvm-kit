//
//  FRViewModelProtocol.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRViewModelBecomeActiveProtocol.h"
#import "FRViewModelDidLoadViewProtocol.h"
#import "FRViewModelDidLayoutSubviewsProtocol.h"
#import "FRViewModelLoadingProtocol.h"
#import "FRViewModelToastProtocol.h"
#import "FRViewModelEmptyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FRViewModelProtocol  <FRViewModelBecomeActiveProtocol,
                                FRViewModelDidLoadViewProtocol,
                                FRViewModelDidLayoutSubviewsProtocol,
                                FRViewModelLoadingProtocol,
                                FRViewModelToastProtocol,
                                FRViewModelEmptyProtocol>
@required
/**
 *  @brief navigation bar title
 */
@property (nullable, nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
