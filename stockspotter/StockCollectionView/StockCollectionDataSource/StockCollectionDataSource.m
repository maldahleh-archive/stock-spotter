//
//  StockCollectionDataSource.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-11.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "StockCollectionDataSource.h"
#import "StockCell.h"
#import "StockData.h"

@interface StockCollectionDataSource ()
@property (nonatomic, strong) NSMutableArray *stockData;
@end

@implementation StockCollectionDataSource

static NSString * const reuseIdentifier = @"StockCell";

- (void)updateData:(UICollectionView*)collectionView {
    self.stockData = [NSMutableArray array];
    [self refreshCells:collectionView];
}

- (void)refreshCells:(UICollectionView*)collectionView {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"https://api.iextrading.com/1.0/stock/market/batch?symbols=aapl,amzn,msft,fb,brk.b,jpm,xom,jnj,v,bac,wfc,intc,wmt,cvx,unh,hd,ba,pfe,ma,t,csco,vz,orcl,pg,ko,c,mrk,nvda,nflx,dis,cmcsa,mcd,ibm,adbe,nke,ge,hon,txn,unp,bkng,ups,pypl,crm,cat,lmt,cost,gs,axp,low,sbux,twx,khc,fdx,cvs,chtr,gm,rtn,gd,fox,aaba,tsla,mar,ttwo,z,has,dbx,trip,colm,jblu,mat,wen,noc,bk,f,tgt,hpq,race,twtr,spot,luv,tri,cp,sq,k,bby,cbs,hsy,snap,efx,shop,qsr,tru,ihg,cmg,gddy,m,dpz,wu,grub,h&types=quote"];
    
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StockCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    StockData *stockAtCell = [self.stockData objectAtIndex:indexPath.row];
    cell.stockSymbol.text = stockAtCell.symbol;
    
    cell.footerLabel.text = [NSString stringWithFormat:@"%.2f", stockAtCell.latestPrice];
    
    return cell;
}

@end
