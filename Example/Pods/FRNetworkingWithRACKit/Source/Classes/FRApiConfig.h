//
//  FRApiConfig.h
//  FRNetworkingWithRACKit
//
//  Created by 曾凡旭 on 2017/5/10.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRApiServerProtocol.h"
#import "FRNetConfigProtocol.h"

@interface FRApiConfig : NSObject<FRApiServerProtocol,FRNetConfigProtocol>

@end
