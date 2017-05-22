//
//  FRApiAppClient.h
//  FRNetworkingWithRACKit
//
//  Created by 曾凡旭 on 2017/5/10.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import "FRApiClient.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface FRApiAppClient : FRApiClient

+(FRApiAppClient *)sharedClient;

- (RACSignal *)requestWithMethod:(FRRequestMethod)method
                    relativePath:(NSString *)relativePath
                      parameters:(NSDictionary *)parameters
                        needAuth:(BOOL)needAuth;

@end
