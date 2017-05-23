//
//  FRViewModelEmptyProtocol.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FRViewModelEmptyProtocol <NSObject>

/**
 *  @brief  If YES, shows the empty view, default is NO.
 */
@property (nonatomic, assign, getter=isEmpty) BOOL empty;

/**
 *  @brief  Set empty=YES, shows the empty view with description.
 */
- (void)setEmptyWithDescription:(NSString *)description;
@end
