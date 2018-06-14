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

+ (instancetype) stockWithDictionary:(NSDictionary *) dictionary {
    StockData *stock = [[StockData alloc] init];
    
    if (stock) {
        stock.symbol = [dictionary valueForKeyPath:@"symbol"];
        
        NSMutableString *urlString = [NSMutableString stringWithString:@"https://storage.googleapis.com/iex/api/logos/"];
        [urlString appendString:stock.symbol];
        [urlString appendString:@".png"];
        
        stock.logoUrl = [NSURL URLWithString:urlString];
        stock.latestPrice = [[dictionary valueForKeyPath:@"latestPrice"] doubleValue];
        stock.avgTotalVolume = [NumberUtils suffixNumber:((NSNumber*) [dictionary valueForKeyPath:@"avgTotalVolume"])];
        stock.marketCap = [NumberUtils suffixNumber:((NSNumber*) [dictionary valueForKeyPath:@"marketCap"])];
        stock.week52Low = [[dictionary valueForKeyPath:@"week52Low"] doubleValue];
        stock.week52High = [[dictionary valueForKeyPath:@"week52High"] doubleValue];
        
    }
    
    return stock;
}

@end
