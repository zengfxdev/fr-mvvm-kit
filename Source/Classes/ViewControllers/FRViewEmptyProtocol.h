//
//  FRViewEmptyProtocol.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FRViewEmptyProtocol <NSObject>

@optional

- (void)hideEmptyView;

- (void)showEmptyViewWithDescription:(NSString *_Nullable)description;

@end
