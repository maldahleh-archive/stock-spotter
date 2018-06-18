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
    
    [self setupGestures];
}

#pragma mark - Gestures
- (void)setupGestures {
    UITapGestureRecognizer *dismiss = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismiss)];
    dismiss.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:dismiss];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDismiss)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
}

- (void)swipeDismiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(400, 0);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.75 animations:^{
        self.view.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
