#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "DDLogServiceManager.h"
#import "FRLogger.h"
#import "FRLoggerKit.h"

FOUNDATION_EXPORT double FRLoggerKitVersionNumber;
FOUNDATION_EXPORT const unsigned char FRLoggerKitVersionString[];

