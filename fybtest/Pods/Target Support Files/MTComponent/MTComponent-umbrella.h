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

#import "MTComponent.h"
#import "MTComponentProtocol.h"
#import "MTCompServiceModel.h"
#import "MTCompViewModelProtocol.h"
#import "MTCompVM.h"
#import "MTTComContainerVC.h"
#import "MTTComContainerVM.h"
#import "UIViewController+MTComponent.h"

FOUNDATION_EXPORT double MTComponentVersionNumber;
FOUNDATION_EXPORT const unsigned char MTComponentVersionString[];

