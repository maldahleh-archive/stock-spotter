//
//  NetworkingUtils.h
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-14.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NetworkingUtils : NSObject
+ (void)dowloadImageWith:(NSURL*)url forLogoView:(UIImageView*)logoView;
@end
