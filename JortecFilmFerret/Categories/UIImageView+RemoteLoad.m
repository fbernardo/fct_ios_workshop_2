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
    
    if(! image)
        [self loadRemoteImageFromURL:url];
    else
        self.image = image;
}

#pragma mark - Private methods

- (void)loadRemoteImageFromURL:(NSString*) url
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if(! error && data)
        {
            UIImage *image = [UIImage imageWithData:data];
            self.image = image;
            [[RFSimpleImageCache sharedSimpleImageCache] addImage:image key:url];
        }
    }]resume];
}
@end
