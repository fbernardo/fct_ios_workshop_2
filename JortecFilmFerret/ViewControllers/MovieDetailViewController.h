//
//  MovieDetailViewController.h
//  JortecFilmFerret
//
//  Created by Rodrigo on 29/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *posterGrid;

@property (nonatomic,strong) NSArray *movies;
@property (nonatomic,readwrite) NSInteger selectedMovieIndex;
@property (nonatomic, readwrite) BOOL shouldHideStatusBar;

- (IBAction)didTapView:(UITapGestureRecognizer *)sender;

@end
