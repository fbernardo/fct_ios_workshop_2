//
//  MovieGridCell.m
//  JortecFilmFerret
//
//  Created by Rodrigo on 17/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import "MovieGridCell.h"

@implementation MovieGridCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.movieImage.image = [UIImage imageNamed:@"ph_image_small.png"];
    self.movieImage.contentMode = UIViewContentModeCenter;
    self.movieTitle.text = nil;
}

@end
