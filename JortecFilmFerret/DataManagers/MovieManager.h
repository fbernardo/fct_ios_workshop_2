//
//  MovieManager.h
//  JortecFilmFerret
//
//  Created by Rodrigo on 27/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieManager : NSObject

- (void)fetchMoviesWithAdult:(BOOL)adult completionHandler:(void (^)(NSArray* movies))handler;

@end
