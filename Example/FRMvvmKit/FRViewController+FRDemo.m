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

@implementation FRViewController (FRDemo)



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
