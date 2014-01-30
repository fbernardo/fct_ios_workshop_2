//
//  MovieGridCell.m
//  JortecFilmFerret
//
//  Created by Rodrigo on 17/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import "MovieGridCell.h"
#import "UIImage+WithColor.h"

@implementation MovieGridCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.movieImage.image = [UIImage imageNamed:@"place_holder.png"];
    self.movieTitle.text = nil;
}

@end
