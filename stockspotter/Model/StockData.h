//
//  StockData.h
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-10.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockData : NSObject
@property (nonatomic, strong) NSURL *logoUrl;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic) double latestPrice;
@property (nonatomic) double week52High;
@property (nonatomic) double week52Low;
@property (nonatomic, strong) NSString *avgTotalVolume;
@property (nonatomic, strong) NSString *marketCap;

+ (instancetype) stockWithDictionary:(NSDictionary *) dictionary;
@end
