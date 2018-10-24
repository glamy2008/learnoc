//
//  MTCompCollectionViewLayout.h
//  MTCompCollectionView
//
//  Created by Jason Li on 2018/3/23.
//

#import <UIKit/UIKit.h>

@interface MTCompCollectionViewLayout : UICollectionViewFlowLayout

// 每行显示几个
@property (nonatomic) NSUInteger itemCountRow;
// 显示多少行
@property (nonatomic) NSUInteger rowCount;

@property (strong, nonatomic) NSMutableArray *allAttributes;


@end
