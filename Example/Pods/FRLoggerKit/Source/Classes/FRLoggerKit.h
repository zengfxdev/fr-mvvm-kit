//
//  FRLoggerKit.h
//  FRLoggerKit
//
//  Created by 曾凡旭 on 2017/5/9.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#ifndef FRLoggerKit_h
#define FRLoggerKit_h

#import <CocoaLumberjack/CocoaLumberjack.h>

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelError;
#endif

#endif /* FRLoggerKit_h */
