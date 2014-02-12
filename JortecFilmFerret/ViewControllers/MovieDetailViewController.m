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

@implementation MovieDetailViewController {
    BOOL _shouldHideStatusBar;
}

#pragma mark - UIViewController

-(BOOL)prefersStatusBarHidden {
    return _shouldHideStatusBar;
}

-(UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *movie = (NSDictionary*)self.movies[self.selectedMovieIndex];
    self.navigationItem.title = movie[@"title"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:self.selectedMovieIndex inSection:0];
    [self.posterGrid scrollToItemAtIndexPath:selectedIndexPath
                            atScrollPosition:UICollectionViewScrollPositionNone
                                    animated:NO];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.posterGrid.collectionViewLayout;
    layout.itemSize = self.posterGrid.bounds.size;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.movies count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieDetailGridCell *cell = (MovieDetailGridCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieDetailGridCell"
                                                                                                  forIndexPath:indexPath];
    
    NSDictionary *movieData = self.movies[indexPath.row];
    
    NSString *movieURL = (NSString*) movieData[@"poster_path"];
    
    if(![movieURL isEqual:[NSNull null]]) {
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

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    if(velocity.x > 0 && self.selectedMovieIndex < self.movies.count - 1)
        self.selectedMovieIndex++;
    else if(velocity.x < 0 && self.selectedMovieIndex > 0)
        self.selectedMovieIndex--;
    
}

#pragma mark - UITapGestureRecognizer

- (IBAction)didTapView:(UITapGestureRecognizer *)sender
{
    BOOL isHidden = self.navigationController.navigationBarHidden;
    _shouldHideStatusBar = !isHidden;
    
    [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                [self setNeedsStatusBarAppearanceUpdate];
    } completion:nil];
    
    [self.navigationController setNavigationBarHidden:_shouldHideStatusBar animated:YES];
}

@end
