//
//  FRViewModel.m
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import "FRViewModel.h"

@implementation FRViewModel

@synthesize title = _title;
@synthesize empty = _empty;
@synthesize loading = _loading;
@synthesize loadingSignal = _loadingSignal;
@synthesize needRetryLoading = _needRetryLoading;
@synthesize didLoadView = _didLoadView;
@synthesize didLoadViewSignal = _didLoadViewSignal;
@synthesize didUnloadViewSignal = _didUnloadViewSignal;
@synthesize didLayoutSubviews = _didLayoutSubviews;
@synthesize didLayoutSubviewsSignal = _didLayoutSubviewsSignal;
//@synthesize submitting = _submitting;
@synthesize successSubject = _successSubject;
@synthesize errorSubject = _errorSubject;

#pragma mark - FRViewModelDidLoadViewProtocol
- (RACSignal *)didLoadViewSignal {
    if (_didLoadViewSignal == nil) {
        @weakify(self);
        _didLoadViewSignal = [[[RACObserve(self, didLoadView) filter:^(NSNumber *didLoadView) {
            return didLoadView.boolValue;
        }] map:^(id _) {
            @strongify(self);
            return self;
        }] setNameWithFormat:@"%@ -didLoadViewSignal", self];
    }
    return _didLoadViewSignal;
}

- (RACSignal *)didUnloadViewSignal {
    if (_didUnloadViewSignal == nil) {
        @weakify(self);
        _didUnloadViewSignal = [[[RACObserve(self, didLoadView) filter:^(NSNumber *didLoadView) {
            return (BOOL)(didLoadView.boolValue == NO);
        }] map:^(id _) {
            @strongify(self);
            return self;
        }] setNameWithFormat:@"%@ -didUnloadViewSignal", self];
    }
    return _didUnloadViewSignal;
}

#pragma mark - FRViewModelDidLayoutSubviewsProtocol
- (RACSignal *)didLayoutSubviewsSignal {
    if (nil == _didLayoutSubviewsSignal) {
        @weakify(self);
        _didLayoutSubviewsSignal = [[[RACObserve(self, didLayoutSubviews) filter:^(NSNumber *didLayoutSubviews) {
            return didLayoutSubviews.boolValue;
        }] map:^(id _) {
            @strongify(self);
            return self;
        }] setNameWithFormat:@"%@ -didLayoutSubviewsSignal", self];
    }
    return _didLayoutSubviewsSignal;
}

#pragma mark - FRViewModelLoadingProtocol
- (void)setLoading:(BOOL)loading {
    @synchronized(self) {
        if (_loading == loading) {
            return;
        }
        _loading = loading;
        if (loading && _loadingSignal) {
            [[_loadingSignal deliverOnMainThread] subscribeNext:^(id x){
            }];
        }
    }
}

- (void)setLoadingSignal:(nullable RACSignal *)loadingSignal {
    if (_loadingSignal == loadingSignal) {
        return;
    }
    @weakify(self);
    if (loadingSignal) {
        _loadingSignal = [[loadingSignal doCompleted:^{
            @strongify(self);
            self.loading = NO;
        }] doError:^(NSError *error) {
            @strongify(self);
            self.loading = NO;
            
            [self.errorSubject sendError:[NSError errorWithDomain:@""
                                                             code:error.code
                                                         userInfo:@{
                                                                    @"signal":[RACTuple tupleWithObjects:_loadingSignal, nil]
                                                                    }]];
            
//            if (error.code == -1001 || error.code == -1004) { // 超时重试
//                self.needRetryLoading = YES;
//            } else {
//                [self.errorSubject sendNext:error.localizedDescription];
//            }
        }];
    } else {
        _loadingSignal = nil;
    }
}

#pragma mark - FRViewModelToastProtocol
- (RACSubject *)successSubject {
    return _successSubject ?: (_successSubject = [RACSubject subject]);
}

- (RACSubject *)errorSubject {
    return _errorSubject ?: (_errorSubject = [RACSubject subject]);
}

#pragma mark - FRViewModelEmptyProtocol
- (void)setEmptyWithDescription:(NSString *)description {
    _empty = YES;
}

- (void)dealloc {
    [_errorSubject sendCompleted];
    [_successSubject sendCompleted];
}


@end
