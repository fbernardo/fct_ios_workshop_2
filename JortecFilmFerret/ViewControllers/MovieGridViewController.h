//
//  MovieGridViewController.h
//  JortecFilmFerret
//
//  Created by Rodrigo on 17/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieGridViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *moviesGrid;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
