//
//  StockHeader.h
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-12.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockHeader : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *typeHeader;

- (void)updateWith:(double)displayed;
@end
