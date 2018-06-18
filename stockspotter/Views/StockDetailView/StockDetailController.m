//
//  StockDetailController.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-17.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "StockDetailController.h"
#import "NetworkingUtils.h"

@interface StockDetailController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *companyDescription;
@property (weak, nonatomic) IBOutlet UILabel *companyCEO;
@property (weak, nonatomic) IBOutlet UILabel *companyExchange;
@property (weak, nonatomic) IBOutlet UILabel *companyIndustry;
@property (weak, nonatomic) IBOutlet UILabel *companySector;
@property (weak, nonatomic) IBOutlet UILabel *companyURL;
@end

@implementation StockDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NetworkingUtils dowloadImageWith:self.selectedStock.logoUrl forLogoView:self.logoView];
    [self.companyName setText:self.selectedStock.companyName];
    [self.companyDescription setText:self.selectedStock.compDescription];
    [self.companyCEO setText:self.selectedStock.ceo];
    [self.companyExchange setText:self.selectedStock.exchange];
    [self.companyIndustry setText:self.selectedStock.industry];
    [self.companySector setText:self.selectedStock.sector];
    [self.companyURL setText:self.selectedStock.website];
}

@end
