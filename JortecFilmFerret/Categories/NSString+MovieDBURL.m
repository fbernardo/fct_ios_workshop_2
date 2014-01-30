//
//  NSString+MovieDBURL.m
//  JortecFilmFerret
//
//  Created by Rodrigo on 28/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import "NSString+MovieDBURL.h"

@implementation NSString (MovieDBURL)

- (NSString*)fullPosterURL
{
    return [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w500/%@", self];
}

@end
