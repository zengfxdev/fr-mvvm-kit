//
//  FRApiAppClient.m
//  FRNetworkingWithRACKit
//
//  Created by 曾凡旭 on 2017/5/10.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import "FRApiAppClient.h"
#import "FRApiAppConfig.h"
#import <FRLoggerKit/FRLogger.h>
#import "FRApiResponse.h"
#import <ReactiveObjC/RACErrorSignal.h>

@implementation FRApiAppClient

+(FRApiAppClient *)sharedClient{
    static FRApiAppClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FRApiAppConfig *config = [FRApiAppConfig sharedConfig];
        [config setRequestTimeoutInterval:120];
        [config setServerUrl:@"http://192.168.1.124:8003"];
        
        instance = [[FRApiAppClient alloc] initWithConfig:config];
    });
    return instance;
}

-(id)init{
    self = [super init];
    if(self){
        
    }
    return self;
}

- (RACSignal *)requestWithMethod:(FRRequestMethod)method
                    relativePath:(NSString *)relativePath
                      parameters:(NSDictionary *)parameters
                        needAuth:(BOOL)needAuth{
    RACSignal *requestSignal = nil;
    
    if (method == FRRequestMethodGet) {
        requestSignal = [self rac_GET:relativePath parameters:parameters];
    }
    
    if (method == FRRequestMethodPut) {
        requestSignal = [self rac_PUT:relativePath parameters:parameters];
    }
    
    if (method == FRRequestMethodPost) {
        requestSignal = [self rac_POST:relativePath parameters:parameters];
    }
    
    if (method == FRRequestMethodPatch) {
        requestSignal = [self rac_PATCH:relativePath parameters:parameters];
    }
    
    if (method == FRRequestMethodDelete) {
        requestSignal = [self rac_DELETE:relativePath parameters:parameters];
    }
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        RACCompoundDisposable *disposable = [RACCompoundDisposable compoundDisposable];
        
        __block id lastSelfValue = nil;
        
        void (^sendNext)(void) = ^{
            @synchronized (disposable) {
                if (lastSelfValue == nil) return;
                
                id responseObject = lastSelfValue;
                FRApiResponse *response = [[FRApiResponse alloc] initWithResponseObj:responseObject];
                
                if(response.status != FRApiResponseStatus_Success){
                    [subscriber sendError:response.error];
                }
                else{
                    [subscriber sendNext:RACTuplePack(lastSelfValue)];
                }
            }
        };
        
        RACDisposable *selfDisposable = [requestSignal subscribeNext:^(RACTuple *value) {
            
            @synchronized (disposable) {
                lastSelfValue = value.first ?: RACTupleNil.tupleNil;
                sendNext();
            }
            
        } error:^(NSError *error) {
            [subscriber sendError:error];
        } completed:^{
            [subscriber sendCompleted];
        }];
        
        [disposable addDisposable:selfDisposable];
        
        return disposable;
    }] catch:^RACSignal *(NSError *error) {
        if(error.code == FRApiResponseStatus_ErrorServer_TokenBlcakList){
            NSLog(@"token过期!");
        }
        return [RACErrorSignal error:error];
    }];
}



@end
