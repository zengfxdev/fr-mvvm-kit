//
//  FRApiResponse.m
//  FRNetworkingWithRACKit
//
//  Created by 曾凡旭 on 2017/5/11.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import "FRApiResponse.h"

@interface FRApiResponse()
@property (nonatomic,assign,readwrite)   FRApiResponseStatus status;
@property (nonatomic,copy,readwrite)     NSError      *error;
@property (nonatomic,copy,readwrite)     id responseObject;
@end

@implementation FRApiResponse

- (instancetype)initWithResponseObj:(id)responseObject
{
    self = [super init];
    if(self){
        self.responseObject = responseObject;
        self.status = [self responseStatusWithError];
    }
    return self;
}

-(void)setResponseObject:(id)responseObject{
    if( [responseObject isKindOfClass:[NSArray class]] ){
        _responseObject = (NSArray *)responseObject;
    }
    else if ([responseObject isKindOfClass:[NSDictionary class]]){
        _responseObject = (NSDictionary *)responseObject;
    }
}

#pragma mark - - private methods
- (FRApiResponseStatus)responseStatusWithError
{
    FRApiResponseStatus responseStatus = FRApiResponseStatus_Success;
    
    // 服务端异常错误
    if( [_responseObject isKindOfClass:[NSArray class]] ){
        
        NSArray *list = _responseObject;
        if( list == nil || list.count == 0){
            responseStatus = FRApiResponseStatus_ErrorServer_DataError;
            
            [self createServerErrorWithCode:1000 desc:@"返回数据错误,Array类型,数据为空!" msg:@""];
        }
    }
    else if( [_responseObject isKindOfClass:[NSDictionary class]] ){
        NSDictionary *result = (NSDictionary *)_responseObject;
        if( result == nil || result.count == 0 ){
            responseStatus = FRApiResponseStatus_ErrorServer_DataError;
            
            [self createServerErrorWithCode:1000 desc:@"返回数据错误,Dict类型,数据为空!" msg:@""];
        }
        else{
            NSString *code = [self dicGetString:result aKey:@"code"];
            NSString *msg = [self dicGetString:result aKey:@"message"];
            
            if( code.length > 0 && ![code isEqualToString:@"0"] ){
                
                // 表示token被加入黑名单
                if( [code isEqualToString:@"500"] ){
                    responseStatus = FRApiResponseStatus_ErrorServer_TokenBlcakList;
                    
                    [self createServerErrorWithCode:responseStatus desc:@"App处理:清空Token" msg:msg];
                }
                else{
                    responseStatus = FRApiResponseStatus_ErrorServer;
                    [self createServerErrorWithCode:[code integerValue] desc:@"" msg:msg];
                }
            }
        }
    }
    
    return responseStatus;
}

#pragma mark - private method
-(void)createServerErrorWithCode:(NSInteger)code desc:(NSString *)desc msg:(NSString *)msg{
//    NSMutableString *errorlog = [[NSMutableString alloc] initWithString:@"服务端错误>> "];
    
    
    self.error = [NSError errorWithDomain:@"YPServerError" code:code userInfo:@{
                                                                                @"response":self
                                                                                }];
}

#pragma mark - tool methods
-(NSString *)dicGetString:(NSDictionary *)dic aKey:(id)aKey{
    if (dic == nil) {
        return nil;
    }
    id result = [dic objectForKey:aKey];
    if ( result && [result isKindOfClass:[NSNumber class]] ) {
        return [NSString stringWithFormat:@"%@",result];
    }else if (result && [result isKindOfClass:[NSString class]] ){
        return (NSString*)result;
    }
    return nil;
}


@end
