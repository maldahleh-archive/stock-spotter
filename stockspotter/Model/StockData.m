//
//  StockData.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-10.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "StockData.h"

@implementation StockData

+ (instancetype) stockWithDictionary:(NSDictionary *) dictionary {
    StockData *stock = [[StockData alloc] init];
    
    if (stock) {
        stock.symbol = [dictionary valueForKeyPath:@"symbol"];
        
        NSMutableString *urlString = [NSMutableString stringWithString:@"https://storage.googleapis.com/iex/api/logos/"];
        [urlString appendString:stock.symbol];
        [urlString appendString:@".png"];
        
        stock.logoUrl = [NSURL URLWithString:urlString];
        stock.avgTotalVolume = [[dictionary valueForKeyPath:@"avgTotalVolume"] doubleValue];
        stock.week52Low = [[dictionary valueForKeyPath:@"week52Low"] doubleValue];
        stock.week52High = [[dictionary valueForKeyPath:@"week52High"] doubleValue];
    }
    
    return stock;
}

@end
