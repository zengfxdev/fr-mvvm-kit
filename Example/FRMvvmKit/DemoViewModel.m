//
//  DemoViewModel.m
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/18.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import "DemoViewModel.h"
#import "NSString+Hash.h"
#import "FRApiAppClient.h"

@implementation DemoViewModel

-(id)init{
    self = [super init];
    if(self){
        
        NSDictionary *dict = @{
                               @"mobile":@"15972226543",
                               @"password":[@"yp123456" sha256String],
                               };
        
        @weakify(self);
//        RACSignal *reqeustSignal = [[FRApiAppClient sharedClient] requestWithMethod:FRRequestMethodPost
//                                            relativePath:@"/v1/authenticate"
//                                              parameters:dict
//                                                needAuth:NO];
//        
//        [[reqeustSignal doError:^(NSError *error) {
//            @strongify(self);
//            self.needRetryLoading = YES;
//        }] subscribeNext:^(id x) {
//            NSLog(@"x:%@",x);
//        }];
        
        self.loadingSignal = [[[FRApiAppClient sharedClient] requestWithMethod:FRRequestMethodPost
                                                                 relativePath:@"/v1/authenticate"
                                                                   parameters:dict
                                                                     needAuth:NO]
                              doNext:^(id x) {
                                  NSLog(@"x:%@",x);
                              }];
        
        [[self.didLayoutSubviewsSignal take:1] subscribeNext:^(id x) {
            @strongify(self);
            self.loading = YES;
        }];
        
    }
    return self;
}

@end
