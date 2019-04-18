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

#import "MoxieSDK.h"
#import "MoxieSDKOperation.h"
#import "MoxieStatusView.h"

FOUNDATION_EXPORT double MoxieSDK_iOSVersionNumber;
FOUNDATION_EXPORT const unsigned char MoxieSDK_iOSVersionString[];

