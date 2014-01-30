//
//  MovieGridCell.h
//  JortecFilmFerret
//
//  Created by Rodrigo on 17/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieGridCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *movieImage;
@property (strong, nonatomic) IBOutlet UILabel *movieTitle;

@end
