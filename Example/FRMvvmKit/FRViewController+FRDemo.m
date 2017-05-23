//
//  FRViewController+FRDemo.m
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/18.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import "FRViewController+FRDemo.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "KMActivityIndicator.h"
#import <Masonry/Masonry.h>
#import "FRViewModelProtocol.h"

#define kRetryViewTag 999999

@implementation FRViewController (FRDemo)

#pragma mark - FRViewLoadingProtocol
- (void)hideRetryView{
    UIView *prevView = [self.view viewWithTag:kRetryViewTag];
    if (prevView) {
        [prevView removeFromSuperview];
    }
}

- (void)showRetryView{
    [self hideRetryView];
    UIView *prevView = [self.view viewWithTag:kRetryViewTag];
    if (prevView) {
        return;
    }
    
    UIView *retryView = [[UIView alloc] init];
    retryView.tag = kRetryViewTag;
    retryView.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:retryView atIndex:0];
    
    [retryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_error"]];
    [retryView addSubview:iconView];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@150);
        make.centerX.equalTo(retryView);
    }];
    
    UIButton *retrybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [retrybtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [retrybtn setTitle:@"刷新" forState:UIControlStateNormal];
    [retrybtn setBackgroundColor:[UIColor redColor]];
    [retryView addSubview:retrybtn];
    
    [retrybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom).offset(20);
        make.centerX.equalTo(retryView);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    @weakify(self);
    [[retrybtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self hideRetryView];
        [self.viewModel setLoading:YES];
    }];
}

#pragma mark - customLoadingView
- (UIView *)customLoadingView:(UIView *)parentView{
    
    KMActivityIndicator *indicatorView = [[KMActivityIndicator alloc] initWithFrame:CGRectMake(0, 0, 56, 56)];
    indicatorView.color = [UIColor yellowColor];
    [parentView addSubview:indicatorView];
    indicatorView.center = parentView.center;
    
    // 添加自启动的动画
    @weakify(indicatorView);
    [[RACSignal merge:@[
                        [parentView rac_signalForSelector:@selector(didMoveToWindow)],
                        [parentView rac_signalForSelector:@selector(didMoveToSuperview)]
                        ]] subscribeNext:^(id x) {
        @strongify(indicatorView);
        [indicatorView startAnimating];
    }];
    return indicatorView;
}



@end
