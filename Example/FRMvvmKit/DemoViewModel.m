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
        
//        @weakify(self);

        RACSignal *reqeustSignal = [[FRApiAppClient sharedClient] requestWithMethod:FRRequestMethodPost
                                            relativePath:@"/v1/authenticate"
                                              parameters:dict
                                                needAuth:NO];
        
        [reqeustSignal subscribeNext:^(id  _Nullable x) {
            NSLog(@"x:%@",x);
        }];
//        [[reqeustSignal catch:^RACSignal *(NSError *error) {
//            return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//                [subscriber sendNext:@"11"];
//                [subscriber sendCompleted];
//                return nil;
//            }] concat:reqeustSignal];
//        }] subscribeNext:^(id  x) {
//            NSLog(@"x:%@",x);
//        }];
        
//        self.loadingSignal = [[[FRApiAppClient sharedClient] requestWithMethod:FRRequestMethodPost
//                                                                 relativePath:@"/v1/authenticate"
//                                                                   parameters:dict
//                                                                     needAuth:NO]
//                              doNext:^(id x) {
//                                  NSLog(@"value:%@",x);
//                              }];
        
//        [[self.didLayoutSubviewsSignal take:1] subscribeNext:^(id x) {
//            @strongify(self);
//            self.loading = YES;
//        }];
    }
    return self;
}

@end
