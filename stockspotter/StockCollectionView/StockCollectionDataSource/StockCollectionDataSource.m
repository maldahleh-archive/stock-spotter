//
//  StockCollectionDataSource.m
//  stockspotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-11.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "StockCollectionDataSource.h"

@interface StockCollectionDataSource ()  {
}

@property (nonatomic, strong) NSArray * myData;
@end

@implementation StockCollectionDataSource

static NSString * const reuseIdentifier = @"StockCell";

-(id)init {
    
    if (self=[super init]) {
        NSLog(@"%s - initialized", __FUNCTION__);
        self.myData = [NSArray arrayWithObjects: @"Apple", @"Orange", @"Banana", nil];
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

@end
