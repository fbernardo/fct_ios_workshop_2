//
//  MovieManager.m
//  JortecFilmFerret
//
//  Created by Rodrigo on 27/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import "MovieManager.h"

//static NSString * kMovieURL = @"https://api.themoviedb.org/3/movie/popular?api_key=ea644a530ad78ae928787551fdee1f16";
static NSString * kMovieURL = @"https://api.themoviedb.org/3/discover/movie?api_key=ea644a530ad78ae928787551fdee1f16&include_adult=%@&primary_release_year=%d&sort_by=popularity.desc";

@implementation MovieManager

- (void)fetchPopularMoviesForYear:(NSUInteger)year includeAdult:(BOOL)adult completionHandler:(void (^)(NSArray* movies))handler
{
    
    NSString *url = [NSString stringWithFormat:kMovieURL, adult ? @"true" : @"false", year];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:url]
               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

                   NSArray *movies = nil;
                   
                   NSError *jsonParseError = nil;
                   NSDictionary *moviesJSON = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &jsonParseError];
    
                   if(!jsonParseError)
                   {
                       movies = (NSArray*)moviesJSON[@"results"];
                   }
                   
                   if(handler) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           handler(movies);
                       });
                   }
                   
 
               }] resume];
}

@end
