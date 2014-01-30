//
//  RFSimpleImageCache.h
//  JortecFilmFerret
//
//  Created by Rodrigo on 28/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFSimpleImageCache : NSObject

+ (instancetype)sharedSimpleImageCache;

- (void)addImage: (UIImage*)image key: (NSString*) key;
- (UIImage*) imageForKey: (NSString*) key;
- (void)clearCache;

@end
