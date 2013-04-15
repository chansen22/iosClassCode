//
//  ITunesFetcher.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/17/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#define NUMBER_OF_MEDIA_ITEMS 100

#import "ITunesFetcher.h"
#import "ITunesMediaItem.h"
#import "ITunesFetcherData.h"

@implementation ITunesFetcher

// Make sure you call these methods within a new thread or the main will block

+ (NSArray *)getDataFromString:(NSString *)string {
  NSURL *url = [[NSURL alloc] initWithString:string];
  NSError *error;
  
  ITunesFetcherData *sharedManager = [ITunesFetcherData sharedManager];
  [sharedManager incrementActivityCounter];
  [NSThread sleepForTimeInterval:drand48() * 3.0];
  NSData *rawJSON = [[NSData alloc] initWithContentsOfURL:url];
  [sharedManager decrementActivityCounter];
  
  NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:rawJSON options:0 error:&error];
  if (error) {
    NSLog(@"JSON Parsing Error: %@", error);
    return nil;
  }
  
  NSMutableArray *mediaItems = [[NSMutableArray alloc] init];
  for (int mediaItemRank = 0; mediaItemRank < NUMBER_OF_MEDIA_ITEMS; mediaItemRank++) {
    ITunesMediaItem *newMediaItem = [[ITunesMediaItem alloc] initWithJSONAttributes:parsedJSON[@"feed"][@"entry"][mediaItemRank] rank:mediaItemRank];
    [mediaItems insertObject:newMediaItem atIndex:mediaItemRank];
  }
  return mediaItems;
}

+ (NSArray *)topFreeApps {
  return [self getDataFromString:@"https://itunes.apple.com/us/rss/topfreeapplications/limit=100/json"];
}

+ (NSArray *)topSongs {
  return [self getDataFromString:@"https://itunes.apple.com/us/rss/topsongs/limit=100/json"];
}

+ (NSArray *)topITunesUCourses {
  return [self getDataFromString:@"https://itunes.apple.com/us/rss/topitunesucourses/limit=100/json"];
}

+ (NSArray *)topMovies {
  return [self getDataFromString:@"https://itunes.apple.com/us/rss/topmovies/limit=100/json"];
}

+ (NSArray *)topFreeBooks {
  return [self getDataFromString:@"https://itunes.apple.com/us/rss/topfreeebooks/limit=100/json"];
}

+ (NSArray *)topPodcasts {
  return [self getDataFromString:@"https://itunes.apple.com/us/rss/toppodcasts/limit=100/json"];
}

@end
