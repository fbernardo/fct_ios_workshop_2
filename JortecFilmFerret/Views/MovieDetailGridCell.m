//
//  MovieDetailGridCell.m
//  JortecFilmFerret
//
//  Created by Rodrigo on 29/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import "MovieDetailGridCell.h"

@implementation MovieDetailGridCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.posterImage.image = [UIImage imageNamed:@"place_holder.png"];
}

@end
