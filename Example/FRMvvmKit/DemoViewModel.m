//
//  DemoViewModel.m
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/18.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import "DemoViewModel.h"

@implementation DemoViewModel

-(id)init{
    self = [super init];
    if(self){
        @weakify(self);
        self.loadingSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@""];
                [subscriber sendCompleted];
            });
            return nil;
        }];
        
        [[self.didLayoutSubviewsSignal take:1] subscribeNext:^(id x) {
            @strongify(self);
            self.loading = YES;
        }];
    }
    return self;
}

@end
