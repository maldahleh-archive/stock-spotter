//
//  NetworkingUtils.m
//  StockSpotter
//
//  Created by Mohammed Al-Dahleh on 2018-06-14.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

#import "NetworkingUtils.h"

@implementation NetworkingUtils

+ (void)dowloadImageWith:(NSURL*)url forLogoView:(UIImageView*)logoView; {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            logoView.image = image;
        });
    }];
    
    [task resume];
}

@end
