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

#import "FRApiClient.h"
#import "FRApiConfig.h"
#import "FRApiServerProtocol.h"
#import "FRNetConfigProtocol.h"

FOUNDATION_EXPORT double FRNetworkingWithRACKitVersionNumber;
FOUNDATION_EXPORT const unsigned char FRNetworkingWithRACKitVersionString[];

