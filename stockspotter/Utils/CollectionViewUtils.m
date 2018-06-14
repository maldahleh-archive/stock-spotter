//
//  CollectionViewUtils.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-14.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "CollectionViewUtils.h"

@implementation CollectionViewUtils

+ (void)reloadCollectionView:(UICollectionView*)collectionView {
    [collectionView performBatchUpdates:^{
        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:nil];
}

@end
