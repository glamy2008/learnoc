//
//  MTCollectionItemVM.h
//  MTCompCollectionView
//
//  Created by Jason Li on 2018/3/26.
//

#import "MTCollectionItem.h"
@import MTComponent;

@interface MTCollectionItemVM : MTCompVM

- (NSString *)itemTitleAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)imageNameAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)imageURLAtIndexPath:(NSIndexPath *)indexPath;

- (MTCollectionItem *)collectionItemAtIndexPath:(NSIndexPath *)indexPath;

@end

