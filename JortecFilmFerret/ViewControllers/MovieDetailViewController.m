//
//  MovieDetailViewController.m
//  JortecFilmFerret
//
//  Created by Rodrigo on 29/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MovieDetailGridCell.h"
#import "NSString+MovieDBURL.h"
#import "UIImageView+RemoteLoad.h"

@implementation MovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.topItem.title = @"";
    
    NSDictionary *movie = (NSDictionary*)self.movies[self.selectedMovieIndex];
    self.navigationItem.title = movie[@"title"];
    
    // Hack: UICollectionView with full screen items needs this so the items occupy...full screen! :-)
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.posterGrid.collectionViewLayout;
    layout.itemSize = self.posterGrid.frame.size;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.posterGrid scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectedMovieIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.movies.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailGridCell *cell = (MovieDetailGridCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieDetailGridCell" forIndexPath:indexPath];
    
    NSDictionary *movieData = self.movies[indexPath.row];
    
    NSString *movieURL = (NSString*) movieData[@"poster_path"];
    
    if(![movieURL isEqual:[NSNull null]])
    {
        movieURL = [movieURL fullPosterURL];
        [cell.posterImage setRemoteImageFromURL: movieURL];
    }
    
    return cell;
}

#pragma mark - Pagination

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSDictionary *movie = (NSDictionary*)self.movies[self.selectedMovieIndex];
    self.navigationItem.title = movie[@"title"];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if(velocity.x > 0 && self.selectedMovieIndex < self.movies.count - 1)
        self.selectedMovieIndex++;
    else if(velocity.x < 0 && self.selectedMovieIndex > 0)
        self.selectedMovieIndex--;
}

#pragma mark - UITapGestureRecognizer

- (IBAction)didTapView:(UITapGestureRecognizer *)sender
{
    BOOL isHidden = self.navigationController.navigationBarHidden;
    BOOL shouldShow = ! isHidden;
    
    self.shouldHideStatusBar = shouldShow;
    
    if(! shouldShow)
    {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    else
    {
        [UIView animateWithDuration:0.12 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        } completion:NULL];
    }
    
    [self.navigationController setNavigationBarHidden:shouldShow animated:YES];
}

@end
