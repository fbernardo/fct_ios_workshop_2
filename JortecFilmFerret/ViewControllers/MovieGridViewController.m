//
//  MovieGridViewController.m
//  JortecFilmFerret
//
//  Created by Rodrigo on 17/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import "MovieGridViewController.h"
#import "MovieManager.h"
#import "MovieGridCell.h"
#import "NSString+MovieDBURL.h"
#import "UIImageView+RemoteLoad.h"
#import "MovieDetailViewController.h"

// https://api.themoviedb.org/3/movie/upcoming?api_key=ea644a530ad78ae928787551fdee1f16

// http://docs.themoviedb.apiary.io/

@interface MovieGridViewController ()

@property (nonatomic,strong) NSArray *movies;

@end

@implementation MovieGridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"1992 Movies";
    
    self.moviesGrid.hidden = YES;

    MovieManager *movieManager = [MovieManager new];
    [movieManager fetchPopularMoviesForYear:1992 includeAdult:YES completionHandler:^(NSArray *movies) {

        if(movies)
        {
            if(movies.count)
            {
                self.movies = movies;
                self.moviesGrid.hidden = NO;
                [self.moviesGrid reloadData];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                                message:@"Seems dat no movies made their way back here..."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Shit! Da loading got skrewed..."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
        }
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.movies.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MovieGridCell *cell = (MovieGridCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieGridCell" forIndexPath:indexPath];
    
    NSDictionary *movieData = self.movies[indexPath.row];
    cell.movieTitle.text = movieData[@"title"];
    
    NSString *movieURL = (NSString*) movieData[@"poster_path"];
    
    if(![movieURL isEqual:[NSNull null]])
    {
        movieURL = [movieURL fullPosterURL];
        [cell.movieImage setRemoteImageFromURL: movieURL];
    }

    return cell;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"gridToDetailSegue"])
    {
        NSArray *selectedIndexPaths = [self.moviesGrid indexPathsForSelectedItems];
        NSIndexPath *selectedIndexPath = [selectedIndexPaths firstObject];
        
        MovieDetailViewController *movieDetailVC = (MovieDetailViewController *) segue.destinationViewController;
        movieDetailVC.movies = self.movies;
        movieDetailVC.selectedMovieIndex = selectedIndexPath.row;
    }
}

@end
