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

@interface StockCollectionViewController ()
@property (strong, nonatomic) NSMutableArray *stockCollection;
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

- (void)refreshCells {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"https://api.iextrading.com/1.0/stock/market/list/mostactive"];
    
    self.stockCollection = [NSMutableArray array];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSArray *stockData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        for (NSDictionary *dict in stockData) {
            StockData *dataObject = [StockData stockWithDictionary:dict];
            [self.stockCollection addObject:dataObject];
        }
    }];
    
    [task resume];
}

@end
