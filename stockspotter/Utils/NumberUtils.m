//
//  NumberUtils.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-14.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "NumberUtils.h"

@implementation NumberUtils

+ (NSString*)suffixNumber:(NSNumber*)number {
    long long num = [number longLongValue];
    
    int s = ((num < 0) ? -1 : (num > 0) ? 1 : 0);
    NSString *sign = (s == -1 ? @"-" : @"");
    
    num = llabs(num);
    
    if (num < 1000)
        return [NSString stringWithFormat:@"%@%lld", sign, num];
    
    int exp = (int) (log10l(num) / 3.f);
    NSArray *units = @[@"K",@"M",@"B",@"T",@"P",@"E"];
    
    return [NSString stringWithFormat:@"%@%.1f%@", sign, (num / pow(1000, exp)), [units objectAtIndex:(exp-1)]];
}

@end
