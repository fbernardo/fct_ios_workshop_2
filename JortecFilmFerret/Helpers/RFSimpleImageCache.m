//
//  RFSimpleImageCache.m
//  JortecFilmFerret
//
//  Created by Rodrigo on 28/01/14.
//  Copyright (c) 2014 JFF. All rights reserved.
//

#import "RFSimpleImageCache.h"

@interface RFSimpleImageCache ()

@property (nonatomic,strong) NSCache *dictionary;

@end

@implementation RFSimpleImageCache

#pragma mark - Init

- (instancetype)init {
    if(self = [super init]) {
        self.dictionary = [[NSCache alloc] init];
    }    
    return self;
}

#pragma mark - Public methods 

+ (instancetype)sharedSimpleImageCache {
    static RFSimpleImageCache *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (void)addImage: (UIImage*)image key: (NSString*) key {
    [self.dictionary setObject:image forKey:key];
}

- (UIImage*) imageForKey: (NSString*) key {
    return [self.dictionary objectForKey:key];
}

- (void)clearCache {
    [self.dictionary removeAllObjects];
}

@end
