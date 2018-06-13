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
        stock.latestPrice = [[dictionary valueForKeyPath:@"latestPrice"] doubleValue];
        stock.avgTotalVolume = [self suffixNumber:((NSNumber*) [dictionary valueForKeyPath:@"avgTotalVolume"])];
        stock.marketCap = [self suffixNumber:((NSNumber*) [dictionary valueForKeyPath:@"marketCap"])];
        stock.week52Low = [[dictionary valueForKeyPath:@"week52Low"] doubleValue];
        stock.week52High = [[dictionary valueForKeyPath:@"week52High"] doubleValue];
    }
    
    return stock;
}

+ (NSString*) suffixNumber:(NSNumber*)number {
    long long num = [number longLongValue];
    
    int s = ((num < 0) ? -1 : (num > 0) ? 1 : 0);
    NSString *sign = (s == -1 ? @"-" : @"");
    
    num = llabs(num);
    
    if (num < 1000)
        return [NSString stringWithFormat:@"%@%lld", sign, num];
    
    int exp = (int) (log10l(num) / 3.f);
    NSArray *units = @[@"K",@"M",@"G",@"T",@"P",@"E"];
    
    return [NSString stringWithFormat:@"%@%.1f%@", sign, (num / pow(1000, exp)), [units objectAtIndex:(exp-1)]];
}

@end
