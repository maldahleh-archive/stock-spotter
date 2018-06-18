//
//  StockCollectionDataSource.h
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-11.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "StockData.h"

@interface StockCollectionDataSource : NSObject <UICollectionViewDataSource>
@property double displayedProperty;

- (void)leftGesture:(UICollectionView*)collectionView;
- (void)rightGesture:(UICollectionView*)collectionView;
- (void)updateData:(UICollectionView*)collectionView;
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView;
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath; 
- (StockData*)stockAt:(NSInteger)location;
@end
