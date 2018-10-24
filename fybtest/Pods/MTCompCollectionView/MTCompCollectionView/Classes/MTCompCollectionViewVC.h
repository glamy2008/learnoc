//
//  MTCompCollectionViewVC.h
//  MTCompCollectionView
//
//  Created by Jason Li on 2018/3/21.
//

#import <UIKit/UIKit.h>
#import "MTCompCollectionViewLayout.h"

@import MTComponent;

NS_ASSUME_NONNULL_BEGIN

@interface MTCompCollectionViewVC : UIViewController<MTComponentProtocol, UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**
 -toReloadComponent时调用，对Layout进行设置调整，子类可重写

 @param layout MTCompCollectionViewLayout 对象
 */
- (void)toPerpareLayout:(MTCompCollectionViewLayout *)layout;

/**
 注册UICollectionViewCell，子类可重写

 @return Cell的类对象
 */
- (nullable Class)registerCollectionViewCellClass;

@end
NS_ASSUME_NONNULL_END
