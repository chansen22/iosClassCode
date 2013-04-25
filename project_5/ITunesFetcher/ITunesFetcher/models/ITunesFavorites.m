//
//  ITunesFavorites.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 4/15/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "ITunesFavorites.h"

@interface ITunesFavorites () <NSCoding>

@property (nonatomic, strong) NSMutableSet  *favorites;
@property (nonatomic, strong) NSCoder       *coder;
//@property (nonatomic, strong) NSURL         *URLForArchive;

@end

@implementation ITunesFavorites

- (ITunesFavorites *)init {
  self = [super init];
  
  BOOL finished = NO;
  
  NSFileManager *fileManager = [NSFileManager defaultManager];
  
  NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  NSString *file = [dir stringByAppendingPathComponent:@"favoritesFile"];
  
  if ([fileManager fileExistsAtPath:file]) {
    self.favorites = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    finished = YES;
  }
  
  if (self && !finished) {
    self.favorites = [[NSMutableSet alloc] init];
    self.coder = [[NSCoder alloc] init];
  }
  return self;
}

- (BOOL)saveFavorites:(NSMutableSet *)favorites {
  NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  NSString *file = [dir stringByAppendingPathComponent:@"favoritesFile"];
  
  return [NSKeyedArchiver archiveRootObject:self.favorites toFile:file];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.favorites forKey:@"Favorites" ];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    self.favorites = [aDecoder decodeObjectForKey:@"Favorites"];
  }
  return self;
}

+ (ITunesFavorites *)sharedFavoritesManager {
  static id sharedManager;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    sharedManager = [[self alloc] init];
  });
  return sharedManager;
}

- (void)addFavorite:(ITunesMediaItem *)mediaItem {
  [self.favorites addObject:mediaItem];
  [self saveFavorites:self.favorites];
}

- (void)removeFavorite:(ITunesMediaItem *)mediaItem {
  [self.favorites removeObject:mediaItem];
  [self saveFavorites:self.favorites];
}

- (NSArray *)allFavorites {
  return [self.favorites allObjects];
}

- (BOOL)isFavorite:(ITunesMediaItem *)mediaItem {
  if ([self.favorites containsObject:mediaItem]) {
    return YES;
  } else {
    return NO;
  }
}

@end
