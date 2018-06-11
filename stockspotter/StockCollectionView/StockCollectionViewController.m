//
//  StockCollectionViewController.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-10.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "StockCollectionViewController.h"
#import "StockData.h"

@interface StockCollectionViewController ()
@property (strong, nonatomic) NSMutableArray *stockCollection;
@end

@implementation StockCollectionViewController

static NSString * const reuseIdentifier = @"StockCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshCells];
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

#pragma mark <UICollectionViewDataSource>

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
