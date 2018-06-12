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
@property (nonatomic, strong) UIRefreshControl *uiRefresher;
@property (nonatomic, strong) StockCollectionDataSource *dataSource;
@end

@implementation StockCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [[StockCollectionDataSource alloc] init];
    self.collectionView.dataSource = self.dataSource;
    
    self.uiRefresher = [[UIRefreshControl alloc] init];
    self.uiRefresher.tintColor = [UIColor colorNamed:@"Seaform"];
    [self.uiRefresher addTarget:self action:@selector(refreshPulled) forControlEvents:UIControlEventValueChanged];
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView addSubview:self.uiRefresher];
    
    [self refreshData];
}

- (void)refreshPulled {
    if ([self.uiRefresher isRefreshing]) { return; }
    
    [self refreshData];
    [self.uiRefresher endRefreshing];
}

- (void)refreshData {
    [self.dataSource updateData:self.collectionView];
}

@end
