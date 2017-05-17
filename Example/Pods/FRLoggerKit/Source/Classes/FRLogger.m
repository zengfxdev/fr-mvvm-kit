//
//  YPLogger.m
//  ReactiveCocoaStudy02
//
//  Created by 曾凡旭 on 2017/4/10.
//  Copyright © 2017年 youpin. All rights reserved.
//

#import "FRLogger.h"
#import "FRLoggerKit.h"

@implementation FRLogger

+ (NSString *)logDebugInfoWithRequest:(NSURLRequest *)request
                              apiName:(NSString *)apiName
                        requestParams:(id)requestParams
                           httpMethod:(NSString *)httpMethod
{
    NSMutableString *logString = [NSMutableString stringWithString:@"\n\n**************************************************************\n*                       Request Start                        *\n**************************************************************\n\n"];
    
    [logString appendFormat:@"API Name:%@\n",apiName];
    [logString appendFormat:@"Method:%@\n",httpMethod];
    [logString appendFormat:@"Request Date:%@\n",[NSDate date]];
    [logString appendFormat:@"Params:\n%@",requestParams];
    
    [logString appendString:[FRLogger getURLRequestString:request]];
    
    [logString appendFormat:@"\n\n**************************************************************\n*                         Request End                        *\n**************************************************************\n\n\n\n"];
#if DEBUG
    DDLogInfo(@"%@", logString);
#endif
    return logString;
}

+ (NSString *)logDebugInfoWithResponse:(NSURLResponse *)response
                    responseJSONObject:(id)responseJSONObject
                               request:(NSURLRequest *)request
                                 error:(NSError *)error
{
    
    NSInteger responseStatusCode = 0;
    id responseHeaders = nil;
    if( [response isKindOfClass:[NSHTTPURLResponse class]] ){
        responseStatusCode = ((NSHTTPURLResponse *)response).statusCode;
        responseHeaders = ((NSHTTPURLResponse *)response).allHeaderFields;
    }
    
    NSMutableString *logString = [NSMutableString stringWithString:@"\n==============================================================\n=                        API Response                        =\n==============================================================\n"];
    
    [logString appendString:[FRLogger getURLRequestString:request]];
    
    [logString appendString:@"\n\n--------------- ^ ^ --------------\n\n"];

    [logString appendFormat:@"► Status:\t%zi\t(%@)\n\n",responseStatusCode,[NSHTTPURLResponse localizedStringForStatusCode:responseStatusCode]];
    
    [logString appendFormat:@"Response Date:%@\n\n",[NSDate date]];
    
    if(responseHeaders){
        [logString appendFormat:@"► ResponseHeaders:\n%@\n\n", responseHeaders];
    }
    if(responseJSONObject){
        [logString appendFormat:@"► ResponseJSONObject:\n%@\n\n", responseJSONObject];
    }
    
    if(error){
        [logString appendFormat:@"✗ Error Domain: %@\n", error.domain];
        [logString appendFormat:@"✗ Error Domain Code: %ld\n", (long)error.code];
        [logString appendFormat:@"✗ Error Localized Description: %@\n", error.localizedDescription];
    }
    
    [logString appendFormat:@"==============================================================\n=                        Response End                        =\n==============================================================\n\n"];
    
    if ((int)responseStatusCode == 200) {
        // 成功
        DDLogInfo(@"%@", logString);
    } else if ( (int)(responseStatusCode/100) >= 5) {
        // 服务端错误
        DDLogError(@"%@", logString);
    }
    else{
        // 网络错误
        DDLogInfo(@"%@",logString);
    }
    
    return logString;
}

#pragma mark - - private methods
+ (NSMutableString *)getURLRequestString:(NSURLRequest *)request
{
    NSMutableString * string = [NSMutableString string];
    [string appendFormat:@"\n\n► HTTP URL:\n%@ %@", request.HTTPMethod, request.URL];
    [string appendFormat:@"\n\n► HTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    
    return string;
}
@end
