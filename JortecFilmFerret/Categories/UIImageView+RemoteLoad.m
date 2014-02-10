//
//  UIImageView+RemoteLoad.m
//  JortecFilmFerret
//
//  Created by Rodrigo on 28/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import "UIImageView+RemoteLoad.h"
#import "RFSimpleImageCache.h"

@implementation UIImageView (RemoteLoad)

#pragma mark - Public methods

- (void)setRemoteImageFromURL:(NSString*) url
{
    UIImage *image = [[RFSimpleImageCache sharedSimpleImageCache] imageForKey:url];
    
    if(! image) {
        [self loadRemoteImageFromURL:url];
    }
    else {
        self.image = image;
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
}

#pragma mark - Private methods

- (void)loadRemoteImageFromURL:(NSString*) url
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session downloadTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if(! error && location)
        {
            NSData *data = [NSData dataWithContentsOfFile:[location path]];
            UIImage *image = [UIImage imageWithData:data];
            [[RFSimpleImageCache sharedSimpleImageCache] addImage:image key:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
                self.contentMode = UIViewContentModeScaleAspectFill;
            });
        }
        
    }] resume];
}
@end
