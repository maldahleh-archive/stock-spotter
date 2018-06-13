//
//  StockHeader.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-12.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "StockHeader.h"

@implementation StockHeader
- (void)updateWith:(double)displayed {
    if (displayed == 0) {
        self.typeHeader.text = @"52 Week Low";
    } else if (displayed == 1) {
        self.typeHeader.text = @"52 Week High";
    } else if (displayed == 2) {
        self.typeHeader.text = @"Latest Price";
    } else if (displayed == 3) {
        self.typeHeader.text = @"Volume";
    } else if (displayed == 4) {
        self.typeHeader.text = @"Unknown";
    }
}
@end
