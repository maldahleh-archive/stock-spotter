//
//  StockCollectionDataSource.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-11.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "StockCollectionDataSource.h"
#import "StockHeader.h"
#import "StockCell.h"
#import "StockData.h"

@interface StockCollectionDataSource ()
@property (nonatomic, strong) NSMutableArray *stockData;
@end

@implementation StockCollectionDataSource
static NSString * const reuseIdentifier = @"StockCell";

- (id)init {
    self = [super init];
    self.displayedProperty = 2;
    
    return self;
}

- (void)leftGesture:(UICollectionView*)collectionView {
    double newValue = self.displayedProperty - 1;
    if (newValue < 0) { newValue = 4; }
    
    self.displayedProperty = newValue;
    [collectionView performBatchUpdates:^{
        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:nil];
}

- (void)rightGesture:(UICollectionView*)collectionView {
    double newValue = self.displayedProperty + 1;
    if (newValue > 4) { newValue = 0; }
    
    self.displayedProperty = newValue;
    [collectionView performBatchUpdates:^{
        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:nil];
}

- (void)updateData:(UICollectionView*)collectionView {
    self.stockData = [NSMutableArray array];
    [self refreshCells:collectionView];
}

- (void)refreshCells:(UICollectionView*)collectionView {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"https://api.iextrading.com/1.0/stock/market/batch?symbols=aapl,fun,msft,fb,brk.b,jpm,xom,jnj,v,bac,wfc,intc,wmt,cvx,unh,hd,ba,pfe,ma,t,csco,vz,orcl,pg,ko,c,mrk,nvda,nflx,dis,mcd,ibm,adbe,nke,ge,hon,txn,unp,six,ups,pypl,crm,cat,lmt,cost,gs,axp,low,sbux,twx,khc,fdx,cvs,chtr,gm,rtn,gd,fox,aaba,tsla,mar,ttwo,z,has,dbx,trip,colm,jblu,mat,wen,noc,bk,f,tgt,hpq,race,twtr,spot,luv,tri,cp,sq,k,bby,cbs,hsy,snap,mtn,shop,qsr,tru,ihg,cmg,gddy,m,dpz,wu,grub,h&types=quote"];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *stockTopDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        for (NSString *dictKey in stockTopDictionary) {
            NSDictionary *stockDict = [stockTopDictionary objectForKey:dictKey];
            NSDictionary *stockQuoteDict = [stockDict objectForKey:@"quote"];
            
            StockData *dataObject = [StockData stockWithDictionary:stockQuoteDict];
            [self.stockData addObject:dataObject];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [collectionView reloadData];
        });
    }];
    
    [task resume];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.stockData.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind != UICollectionElementKindSectionHeader) { return nil; }
    
    StockHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderLabel" forIndexPath:indexPath];
    [header updateWith:self.displayedProperty];
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StockCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 5;
    cell.stockData = [self.stockData objectAtIndex:indexPath.row];
    
    StockData *stockAtCell = [self.stockData objectAtIndex:indexPath.row];
    cell.stockSymbol.text = stockAtCell.symbol;
    
    if (self.displayedProperty == 0) {
        cell.footerLabel.text = [NSString stringWithFormat:@"%.2f", stockAtCell.week52Low];
    } else if (self.displayedProperty == 1) {
        cell.footerLabel.text = [NSString stringWithFormat:@"%.2f", stockAtCell.week52High];
    } else if (self.displayedProperty == 2) {
        cell.footerLabel.text = [NSString stringWithFormat:@"%.2f", stockAtCell.latestPrice];
    } else if (self.displayedProperty == 3) {
        cell.footerLabel.text = stockAtCell.avgTotalVolume;
    } else if (self.displayedProperty == 4) {
        cell.footerLabel.text = stockAtCell.marketCap;
    }
    
    return cell;
}

@end
