//
//  StockCollectionDataSource.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-11.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "AlertUtils.h"
#import "CollectionViewUtils.h"
#import "StockCollectionDataSource.h"
#import "StockHeader.h"
#import "StockCell.h"

@interface StockCollectionDataSource ()
@property (nonatomic, strong) NSMutableArray *stockData;
@end

@implementation StockCollectionDataSource
static NSString* const reuseIdentifier = @"StockCell";

- (id)init {
    self = [super init];
    self.displayedProperty = 2;
    
    return self;
}

#pragma mark - Methods to handle the left and right swipe gestures
- (void)leftGesture:(UICollectionView*)collectionView {
    double newValue = self.displayedProperty - 1;
    if (newValue < 0) { newValue = 4; }
    
    self.displayedProperty = newValue;
    [CollectionViewUtils reloadCollectionView:collectionView];
}

- (void)rightGesture:(UICollectionView*)collectionView {
    double newValue = self.displayedProperty + 1;
    if (newValue > 4) { newValue = 0; }
    
    self.displayedProperty = newValue;
    [CollectionViewUtils reloadCollectionView:collectionView];
}

#pragma mark - Methods to update and download data
- (void)updateData:(UICollectionView*)collectionView {
    self.stockData = [NSMutableArray array];
    [self refreshCells:collectionView];
}

- (void)refreshCells:(UICollectionView*)collectionView {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"https://api.iextrading.com/1.0/stock/market/batch?symbols=aapl,fun,msft,fb,brk.b,jpm,xom,jnj,v,bac,wfc,intc,wmt,cvx,unh,hd,ba,pfe,ma,t,csco,vz,orcl,pg,ko,c,mrk,nvda,nflx,dis,mcd,ibm,adbe,nke,ge,hon,txn,unp,six,ups,pypl,crm,cat,lmt,cost,gs,axp,low,sbux,twx,khc,fdx,cvs,chtr,gm,rtn,gd,fox,aaba,tsla,mar,ttwo,z,has,dbx,trip,colm,jblu,mat,wen,noc,bk,f,tgt,hpq,race,twtr,spot,luv,tri,cp,sq,k,bby,cbs,hsy,snap,mtn,shop,qsr,tru,ihg,cmg,gddy,m,dpz,wu,grub,h&types=quote,company"];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            [AlertUtils alertControllerWithTitle:@"StockSpotter" andBody:[NSString stringWithFormat:@"Error: %@", error.localizedDescription]];
            return;
        }
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *stockTopDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        for (NSString *dictKey in stockTopDictionary) {
            NSDictionary *stockDict = [stockTopDictionary objectForKey:dictKey];
            NSDictionary *stockQuoteDict = [stockDict objectForKey:@"quote"];
            NSDictionary *stockCompanyDict = [stockDict objectForKey:@"company"];
            
            StockData *dataObject = [StockData stockWithQuoteDictionary:stockQuoteDict andCompanyDictionary:stockCompanyDict];
            [self.stockData addObject:dataObject];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [CollectionViewUtils reloadCollectionView:collectionView];
        });
    }];
    
    [task resume];
}

#pragma mark - Data Source Sections and Items methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.stockData.count;
}

#pragma mark - Data Source Header and Cell methods
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind != UICollectionElementKindSectionHeader) { return nil; }
    
    StockHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderLabel" forIndexPath:indexPath];
    [header updateWith:self.displayedProperty];
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StockCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.stockData = [self.stockData objectAtIndex:indexPath.row];
    [cell updateFooter:self.displayedProperty];
    
    return cell;
}

#pragma mark - Utility methods
- (StockData*)stockAt:(NSInteger)location {
    return self.stockData[location];
}

@end
