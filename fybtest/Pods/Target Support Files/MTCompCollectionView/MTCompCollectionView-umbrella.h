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

#import "MTCollectionItem.h"
#import "MTCollectionItemVM.h"
#import "MTCompCollectionViewLayout.h"
#import "MTCompCollectionViewVC.h"

FOUNDATION_EXPORT double MTCompCollectionViewVersionNumber;
FOUNDATION_EXPORT const unsigned char MTCompCollectionViewVersionString[];

