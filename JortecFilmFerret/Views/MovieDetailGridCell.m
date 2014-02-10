//
//  MovieDetailGridCell.m
//  JortecFilmFerret
//
//  Created by Rodrigo on 29/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import "MovieDetailGridCell.h"

@implementation MovieDetailGridCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.posterImage.image = [UIImage imageNamed:@"ph_image_small.png"];
    self.posterImage.contentMode = UIViewContentModeCenter;
}

@end
