//
//  StockCollectionDataSource.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-11.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "StockCollectionDataSource.h"

@interface StockCollectionDataSource ()
@property (nonatomic, strong) NSMutableArray *stockData;
@end

@implementation StockCollectionDataSource

static NSString * const reuseIdentifier = @"StockCell";

-(id)init {
    [self updateData];
    return self;
}

- (void)updateData {
    self.stockData = [NSMutableArray array];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.stockData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure cell
    
    return cell;
}

@end
