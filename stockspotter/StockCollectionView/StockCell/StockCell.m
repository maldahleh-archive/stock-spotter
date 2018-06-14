//
//  StockCell.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-10.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "StockCell.h"
#import "StockData.h"

@implementation StockCell

- (void)setStockData:(StockData *)stockData {
    _stockData = stockData;
    [self roundCorners];
    
    self.stockSymbol.text = self.stockData.symbol;
    self.companyLogoView.image = nil;
    [self dowloadImageWithURL:stockData.logoUrl];
}

#pragma mark - Cell footer display updater
- (void)updateFooter:(int)displayedProperty {
    if (displayedProperty == 0) {
        self.footerLabel.text = [NSString stringWithFormat:@"%.2f", self.stockData.week52Low];
    } else if (displayedProperty == 1) {
        self.footerLabel.text = [NSString stringWithFormat:@"%.2f", self.stockData.week52High];
    } else if (displayedProperty == 2) {
        self.footerLabel.text = [NSString stringWithFormat:@"%.2f", self.stockData.latestPrice];
    } else if (displayedProperty == 3) {
        self.footerLabel.text = self.stockData.avgTotalVolume;
    } else if (displayedProperty == 4) {
        self.footerLabel.text = self.stockData.marketCap;
    }
}

#pragma mark - Cell Rounding
- (void)roundCorners {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
}

#pragma mark - Networking to download image
- (void)dowloadImageWithURL:(NSURL *)url {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.companyLogoView.image = image;
        });
    }];
    
    [task resume];
}

@end
