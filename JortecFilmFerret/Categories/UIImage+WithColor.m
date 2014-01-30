//
//  UIImage+WithColor.m
//  JortecFilmFerret
//
//  Created by Rodrigo on 27/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import "UIImage+WithColor.h"

@implementation UIImage (WithColor)

+ (UIImage*)imageFromColor:(UIColor*)color size:(CGSize)size;
{
    UIImage *result = nil;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [color setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    
    result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}

@end
