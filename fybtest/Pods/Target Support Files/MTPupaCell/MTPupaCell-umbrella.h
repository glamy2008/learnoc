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

#import "MTPupaBaseCell.h"
#import "MTPupaCell.h"
#import "MTPupaFixedHeadAndTailCell.h"
#import "MTPupaFixedTailHeadAndBodyHalfOfRemainCell.h"
#import "MTPupaVerticalCell.h"
#import "MTPupaVerticalFixedHeadAndTailCell.h"
#import "MTPupaVerticalFixedTailHeadAndBodyHalfOfRemainCell.h"

FOUNDATION_EXPORT double MTPupaCellVersionNumber;
FOUNDATION_EXPORT const unsigned char MTPupaCellVersionString[];

