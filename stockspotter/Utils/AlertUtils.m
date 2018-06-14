//
//  AlertUtils.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-14.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "AlertUtils.h"

@implementation AlertUtils

+ (void)alertControllerWithTitle:(NSString*)title andBody:(NSString*)body {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:body preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:alertAction];
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
