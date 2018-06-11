//
//  StockCell.h
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-10.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StockData;

@interface StockCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *companyLogoView;
@property (weak, nonatomic) IBOutlet UILabel *stockSymbol;
@property (weak, nonatomic) IBOutlet UILabel *footerLabel;

@property (strong, nonatomic) StockData *stockData;
@end
