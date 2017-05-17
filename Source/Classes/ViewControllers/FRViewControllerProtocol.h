//
//  FRViewControllerProtocol.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRViewToastProtocol.h"
#import "FRViewNetworkStatusProtocol.h"
#import "FRViewLoadingProtocol.h"
#import "FRViewEmptyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FRViewModelProtocol;

@protocol FRViewControllerProtocol <FRViewToastProtocol,
                                    FRViewNetworkStatusProtocol,
                                    FRViewLoadingProtocol,
                                    FRViewEmptyProtocol>
@required

- (instancetype)initWithViewModel:(__kindof id<FRViewModelProtocol>)viewModel;

@property (nullable, nonatomic, strong, readonly) __kindof id<FRViewModelProtocol> viewModel;

@property(nullable, nonatomic,readonly,strong) UINavigationController *navigationController;

@property(nonatomic,readonly) NSArray<__kindof UIViewController *> *childViewControllers NS_AVAILABLE_IOS(5_0);

- (void)addChildViewController:(UIViewController *)childController NS_AVAILABLE_IOS(5_0);

- (void)removeFromParentViewController NS_AVAILABLE_IOS(5_0);

@end

NS_ASSUME_NONNULL_END
