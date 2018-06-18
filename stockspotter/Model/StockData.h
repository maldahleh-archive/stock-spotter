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

@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *exchange;
@property (nonatomic, strong) NSString *industry;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *compDescription;
@property (nonatomic, strong) NSString *ceo;
@property (nonatomic, strong) NSString *sector;

+ (instancetype) stockWithQuoteDictionary:(NSDictionary*)quoteDict andCompanyDictionary:(NSDictionary*)companyDict;
@end
