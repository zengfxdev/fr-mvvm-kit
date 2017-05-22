//
//  FRApiResponse.h
//  FRNetworkingWithRACKit
//
//  Created by 曾凡旭 on 2017/5/11.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FRApiResponseStatus)
{
    FRApiResponseStatus_Success, // 请求是否成功只考虑是否成功收到服务器反馈。
    FRApiResponseStatus_ErrorTimeout,
    FRApiResponseStatus_ErrorNoNetwork, // 默认除了超时以外的错误都是无网络错误。
    FRApiResponseStatus_ErrorServer=500,     // 服务端错误
    FRApiResponseStatus_ErrorServer_DataError=501,      // 服务端错误_数据异常
    FRApiResponseStatus_ErrorServer_TokenBlcakList=502   // 服务端错误_Token被加入黑名单
};

@interface FRApiResponse : NSObject
@property (nonatomic,assign,readonly)   FRApiResponseStatus status;
@property (nonatomic,copy,readonly)     NSError      *error;
@property (nonatomic,copy,readonly)     id responseObject;

- (instancetype)initWithResponseObj:(id)responseObject;

@end
