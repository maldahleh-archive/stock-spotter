//
//  AlertUtils.h
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-14.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertUtils : NSObject
+ (void)alertControllerWithTitle:(NSString*)title andBody:(NSString*)body;
@end
