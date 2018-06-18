//
//  StockData.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-10.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "StockData.h"
#import "NumberUtils.h"

@implementation StockData

+ (instancetype) stockWithQuoteDictionary:(NSDictionary*)quoteDict andCompanyDictionary:(NSDictionary*)companyDict {
    StockData *stock = [[StockData alloc] init];
    
    if (stock) {
        stock.symbol = [quoteDict valueForKeyPath:@"symbol"];
        
        NSMutableString *urlString = [NSMutableString stringWithString:@"https://storage.googleapis.com/iex/api/logos/"];
        [urlString appendString:stock.symbol];
        [urlString appendString:@".png"];
        
        stock.logoUrl = [NSURL URLWithString:urlString];
        stock.latestPrice = [[quoteDict valueForKeyPath:@"latestPrice"] doubleValue];
        stock.avgTotalVolume = [NumberUtils suffixNumber:((NSNumber*) [quoteDict valueForKeyPath:@"avgTotalVolume"])];
        stock.marketCap = [NumberUtils suffixNumber:((NSNumber*) [quoteDict valueForKeyPath:@"marketCap"])];
        stock.week52Low = [[quoteDict valueForKeyPath:@"week52Low"] doubleValue];
        stock.week52High = [[quoteDict valueForKeyPath:@"week52High"] doubleValue];
        
        stock.companyName = [companyDict valueForKeyPath:@"companyName"];
        stock.exchange = [companyDict valueForKeyPath:@"exchange"];
        stock.industry = [companyDict valueForKeyPath:@"industry"];
        stock.website = [NSURL URLWithString:[companyDict valueForKeyPath:@"website"]];
        stock.compDescription = [companyDict valueForKeyPath:@"description"];
        stock.ceo = [companyDict valueForKeyPath:@"CEO"];
        stock.sector = [companyDict valueForKeyPath:@"sector"];
    }
    
    return stock;
}

@end
