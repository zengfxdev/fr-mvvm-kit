//
//  FRViewController.h
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRViewControllerProtocol.h"

@interface UIViewController (FRViewController) <FRViewControllerProtocol>

@end

@interface FRViewController : UIViewController<FRViewControllerProtocol>

@end
