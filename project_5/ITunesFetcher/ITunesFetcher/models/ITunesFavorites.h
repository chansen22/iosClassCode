//
//  ITunesFavorites.h
//  ITunesFetcher
//
//  Created by Christopher Hansen on 4/15/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITunesMediaItem.h"

@interface ITunesFavorites : NSObject

- (void)addFavorite:   (ITunesMediaItem *)mediaItem;
- (void)removeFavorite:(ITunesMediaItem *)mediaItem;
- (BOOL)isFavorite:    (ITunesMediaItem *)mediaItem;

- (NSArray *)allFavorites;

+ (ITunesFavorites *)sharedFavoritesManager;

@end
