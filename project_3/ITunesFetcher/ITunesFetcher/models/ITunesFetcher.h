//
//  ITunesFetcher.h
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/17/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITunesFetcher : NSObject

+ (NSArray *)topFreeApps;
+ (NSArray *)topSongs;
+ (NSArray *)topITunesUCourses;
+ (NSArray *)topMovies;
+ (NSArray *)topFreeBooks;
+ (NSArray *)topPodcasts;

@end
