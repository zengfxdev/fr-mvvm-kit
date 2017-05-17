//
//  YPLogger.h
//  ReactiveCocoaStudy02
//
//  Created by 曾凡旭 on 2017/4/10.
//  Copyright © 2017年 youpin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRLogger : NSObject

+ (NSString *)logDebugInfoWithRequest:(NSURLRequest *)request
                              apiName:(NSString *)apiName
                        requestParams:(id)requestParams
                           httpMethod:(NSString *)httpMethod;

+ (NSString *)logDebugInfoWithResponse:(NSURLResponse *)response
                    responseJSONObject:(id)responseJSONObject
                               request:(NSURLRequest *)request
                                 error:(NSError *)error;

@end
