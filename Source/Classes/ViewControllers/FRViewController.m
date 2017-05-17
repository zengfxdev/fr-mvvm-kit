//
//  FRViewController.m
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import "FRViewController.h"
#import <objc/runtime.h>
#import "NSObject+FRAssociatedObject.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "FRViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController ()

@property (nullable, nonatomic, strong, readwrite) __kindof id<FRViewModelProtocol> viewModel;

@end

@implementation UIViewController (LPDViewController)

- (nullable __kindof id<FRViewModelProtocol>)viewModel {
    return [self object:@selector(setViewModel:)];
}

- (void)setViewModel:(nullable __kindof id<FRViewModelProtocol>)viewModel {
    [self setRetainNonatomicObject:viewModel withKey:@selector(setViewModel:)];
}

@end


@interface FRViewController ()

@property (nonatomic, strong) UIView *loadingOverlay;
@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicator;

@end

@implementation FRViewController

#pragma mark - life cycle

- (instancetype)initWithViewModel:(__kindof id<FRViewModelProtocol>)viewModel {
    
    NSString *classBundlePath = [[NSBundle bundleForClass:self.class] pathForResource:NSStringFromClass(self.class) ofType:@"nib"];
    if (classBundlePath.length) {
        self = [super initWithNibName:NSStringFromClass(self.class) bundle:[NSBundle bundleForClass:self.class]];
    } else {
        self = [super init];
    }
    
    if (self) {
        self.viewModel = viewModel;
        
        [self subscribeActiveSignal];
        [self subscribeDidLoadViewSignal];
        [self subscribeDidUnloadViewSignal];
        [self subscribeDidLayoutSubviewsSignal];
        [self subscribeLoadingSignal];
        [self subscribeSuccessSubject];
        [self subscribeErrorSubject];
        [self subscribeEmptySignal];
        
        RACChannelTo(self, title) = RACChannelTo(self.viewModel, title);
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - subscribe active signal

- (void)subscribeActiveSignal {
    @weakify(self);
    [[self rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.active = YES;
    }];
    
    [[self rac_signalForSelector:@selector(viewWillDisappear:)] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.active = NO;
    }];
}

#pragma mark - subscribe didLoadView signal
- (void)subscribeDidLoadViewSignal {
    @weakify(self);
    [[self rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.didLoadView = YES;
    }];
}

- (void)subscribeDidUnloadViewSignal {
    @weakify(self);
    [[self rac_signalForSelector:@selector(viewDidUnload)] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.didLoadView = NO;
    }];
}

#pragma mark - subscribe didLayoutSubviews signal
- (void)subscribeDidLayoutSubviewsSignal {
    @weakify(self);
    [[self rac_signalForSelector:@selector(viewDidLayoutSubviews)] subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.didLayoutSubviews = YES;
    }];
}

#pragma mark - subscribe loading signal

- (void)subscribeLoadingSignal {
    @weakify(self);
    [[RACObserve(self.viewModel, loading) skip:1] subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [self showLoading];
        } else {
            [self hideLoading];
        }
    }];
}

- (void)showLoading {
    if (!_loadingOverlay) {
        _loadingOverlay = [[UIView alloc] initWithFrame:self.view.bounds];
        _loadingOverlay.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        UIView *contentView = nil;
        if ([self respondsToSelector:@selector(customLoadingView)]) {
            contentView = [self customLoadingView];
        } else {
            contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            contentView.layer.cornerRadius = 10;
            contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
            
            UIActivityIndicatorView *loadingView =
            [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
            loadingView.tintColor = [UIColor whiteColor];
            [contentView addSubview:loadingView];
            loadingView.center = CGPointMake(50, 50);
            // 添加自启动的动画
            @weakify(loadingView);
            [[[RACSignal merge:@[[_loadingOverlay rac_signalForSelector:@selector(didMoveToWindow)],
                                 [_loadingOverlay rac_signalForSelector:@selector(didMoveToSuperview)]]]
              takeUntil:[_loadingOverlay rac_willDeallocSignal]] subscribeNext:^(id x) {
                @strongify(loadingView);
                [loadingView startAnimating];
            }];
        }
        [_loadingOverlay addSubview:contentView];
        contentView.center = _loadingOverlay.center;
    }
    if (!_loadingOverlay.superview) {
        [self.view addSubview:_loadingOverlay];
    }
}

- (void)hideLoading {
    if (!_loadingOverlay || !_loadingOverlay.superview) {
        return;
    }
    [_loadingOverlay removeFromSuperview];
}

#pragma mark - subscribe toast signal
- (void)subscribeSuccessSubject {
    @weakify(self);
    [[[self.viewModel.successSubject takeUntil:[self rac_willDeallocSignal]] deliverOnMainThread]
       subscribeNext:^(NSString *status) {
          @strongify(self);
          if ([self respondsToSelector:@selector(showSuccess:)]) {
              [self showSuccess:status];
          }
      }];
}

- (void)subscribeErrorSubject {
    @weakify(self);
    [[[self.viewModel.errorSubject takeUntil:[self rac_willDeallocSignal]]
      deliverOnMainThread]
     subscribeNext:^(NSString *message) {
        @strongify(self);
        if (message && message.length > 0) {
            NSLog(@"subscribeErrorSubject post:%@", message);
            if ([self respondsToSelector:@selector(showError:)]) {
                [self showError:message];
            }
        }
    }];
}

#pragma mark - subscribe view empty signal

- (void)subscribeEmptySignal {
    @weakify(self);
    [[[RACObserve(self.viewModel, empty) skip:1] deliverOnMainThread] subscribeNext:^(NSNumber *value) {
        @strongify(self);
        BOOL empty = [value integerValue];
        [self showEmpty:empty withDescription:nil];
    }];
    [[[self.viewModel rac_signalForSelector:@selector(setEmptyWithDescription:)
                               fromProtocol:@protocol(FRViewModelEmptyProtocol)] deliverOnMainThread]
     subscribeNext:^(RACTuple *tuple) {
         @strongify(self);
         [self showEmpty:YES withDescription:tuple.first];
     }];
}

- (void)showEmpty:(BOOL)empty withDescription:(nullable NSString *)description {
//    UIView *rootView = self.view;
    
    if (empty) {
        if ([self respondsToSelector:@selector(showEmptyViewWithDescription:)]) {
            [self showEmptyViewWithDescription:description];
        }
    } else {
        if ([self respondsToSelector:@selector(hideEmptyView)]) {
            [self hideEmptyView];
        }
    }
}

@end

NS_ASSUME_NONNULL_END
