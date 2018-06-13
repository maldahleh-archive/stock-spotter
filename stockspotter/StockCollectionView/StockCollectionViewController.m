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
    
    [self setupGestures];
    [self refreshData];
}

- (void)setupGestures {
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwiped)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.collectionView addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwiped)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.collectionView addGestureRecognizer:rightSwipe];
}

- (void)leftSwiped {
    [self.dataSource performSelector:@selector(leftGesture:) withObject:self.collectionView];
}

- (void)rightSwiped {
    [self.dataSource performSelector:@selector(rightGesture:) withObject:self.collectionView];
}

- (void)refreshPulled {
    [self refreshData];
    [self.uiRefresher endRefreshing];
}

- (void)refreshData {
    [self.dataSource updateData:self.collectionView];
}

@end
