//
//  StockCollectionViewController.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-10.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "StockCollectionViewController.h"
#import "StockCollectionDataSource.h"
#import "StockData.h"
#import "StockDetailController.h"

@interface StockCollectionViewController ()
@property (nonatomic, strong) UIRefreshControl *uiRefresher;
@property (nonatomic, strong) StockCollectionDataSource *dataSource;
@end

@implementation StockCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up data source
    self.dataSource = [[StockCollectionDataSource alloc] init];
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self;
    
    // Set up UI refresher
    self.uiRefresher = [[UIRefreshControl alloc] init];
    self.uiRefresher.tintColor = [UIColor colorNamed:@"Seaform"];
    [self.uiRefresher addTarget:self action:@selector(refreshPulled) forControlEvents:UIControlEventValueChanged];
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView addSubview:self.uiRefresher];
    
    // Set up gestures and refresh the data
    [self setupGestures];
    [self refreshData];
}

#pragma mark - Cell selection
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    StockData *stock = [self.dataSource stockAt:indexPath.row];
    [self performSegueWithIdentifier:@"toDetail" sender:stock];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (![segue.identifier  isEqual: @"toDetail"]) { return; }
    if (![segue.destinationViewController isKindOfClass:StockDetailController.class]) { return; }
    if (![sender isKindOfClass:StockData.class]) { return; }
}

#pragma mark - Methods to setup and call gesture methods
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

#pragma mark - Methods to handle refreshing of data
- (void)refreshPulled {
    [self refreshData];
    [self.uiRefresher endRefreshing];
}

- (void)refreshData {
    [self.dataSource updateData:self.collectionView];
}

@end
