//
//  StockCollectionViewController.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-10.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "StockCollectionViewController.h"
#import "StockCollectionDataSource.h"

@interface StockCollectionViewController ()
@property (nonatomic, strong) StockCollectionDataSource *dataSource;
@end

@implementation StockCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [[StockCollectionDataSource alloc] init];
    self.collectionView.dataSource = self.dataSource;
    
    [self refreshData];
}

- (void)refreshData {
    [self.dataSource updateData];
    [self.collectionView reloadData];
}

@end
