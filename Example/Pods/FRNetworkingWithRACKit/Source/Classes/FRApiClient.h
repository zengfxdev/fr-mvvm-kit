//
//  FRApiClient.h
//  FRNetworkingWithRACKit
//
//  Created by 曾凡旭 on 2017/5/10.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <AFNetworking/AFNetworking.h>
#import "FRApiServerProtocol.h"
#import "FRNetConfigProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , FRRequestMethod) {
    FRRequestMethodGet = 0,
    FRRequestMethodPost,
    FRRequestMethodHead,
    FRRequestMethodPut,
    FRRequestMethodDelete,
    FRRequestMethodPatch,
};

@interface FRApiClient : NSObject

/**
 *  @brief init
 */
- (instancetype)initWithConfig:(nullable NSObject<FRApiServerProtocol,FRNetConfigProtocol> *)config;

/**
 *  @brief AFHTTPSessionManager
 */
@property (nonatomic, strong, readonly) AFHTTPSessionManager *sessionManager;

/**
 *  @brief api server
 */
@property (nonatomic, strong, nullable) NSObject<FRApiServerProtocol,FRNetConfigProtocol> *config;

/**
 *  @brief A convenience around -GET:parameters:success:failure: that returns a cold
 *         signal of the resulting JSON object and response headers or error.
 */
- (RACSignal *)rac_GET:(NSString *)path parameters:(nullable id)parameters;

/**
 *  @brief A convenience around -HEAD:parameters:success:failure: that returns a cold
 *         signal of the resulting response headers or error.
 */
- (RACSignal *)rac_HEAD:(NSString *)path parameters:(nullable id)parameters;

/**
 *  @brief A convenience around -POST:parameters:success:failure: that returns a cold
 *         signal of the resulting JSON object and response headers or error.
 */
- (RACSignal *)rac_POST:(NSString *)path parameters:(nullable id)parameters;

/**
 *  @brief A convenience around -POST:parameters:constructingBodyWithBlock:success:failure:
 *         that returns a cold signal of the resulting JSON object and response headers or error.
 */
- (RACSignal *)rac_POST:(NSString *)path
             parameters:(nullable id)parameters
constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block;

/**
 *  @brief A convenience around -PUT:parameters:success:failure:
 *         that returns a cold signal of the resulting JSON object and response headers or error.
 */
- (RACSignal *)rac_PUT:(NSString *)path parameters:(nullable id)parameters;

/**
 *  @brief A convenience around -PATCH:parameters:success:failure:
 *         that returns a cold signal of the resulting JSON object and response headers or error.
 */
- (RACSignal *)rac_PATCH:(NSString *)path parameters:(nullable id)parameters;

/**
 *  @brief A convenience around -DELETE:parameters:success:failure:
 *         that returns a cold signal of the resulting JSON object and response headers or error.
 */
- (RACSignal *)rac_DELETE:(NSString *)path parameters:(nullable id)parameters;

@end

NS_ASSUME_NONNULL_END
