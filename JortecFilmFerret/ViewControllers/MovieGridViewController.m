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
	// Do any additional setup after loading the view, typically from a nib.
    
    self.moviesGrid.hidden = YES;

    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
    MovieManager *movieManager = [MovieManager new];
    [movieManager fetchMoviesWithAdult:NO completionHandler:^(NSArray *movies) {

        [self.activityIndicator stopAnimating];

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"Da Movies";
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
    MovieGridCell *cell = (MovieGridCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieGridCell" forIndexPath:indexPath];
    
    NSDictionary *movieData = self.movies[indexPath.row];
    cell.movieTitle.text = movieData[@"title"];
    
    NSString *movieURL = (NSString*) movieData[@"poster_path"];
    movieURL = [movieURL fullPosterURL];
    
    [cell.movieImage setRemoteImageFromURL: movieURL];

    return cell;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"gridToDetailSegue"])
    {
        NSArray *selectedIndexPaths = [self.moviesGrid indexPathsForSelectedItems];
        NSIndexPath *selectedIndexPath = (NSIndexPath*)selectedIndexPaths[0];
        
        MovieDetailViewController *movieDetailVC = (MovieDetailViewController *) segue.destinationViewController;
        movieDetailVC.movies = self.movies;
        movieDetailVC.selectedMovieIndex = selectedIndexPath.row;
    }
}

@end
