//
//  PhotoLibrary.m
//  Pickr
//
//  Created by Chris Hansen on 2/26/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "PhotoLibrary.h"

@interface PhotoLibrary ()

@property (strong, nonatomic)NSString *path;
@property (strong, nonatomic)NSDictionary *photoList;

@end

@implementation PhotoLibrary

- (id)init {
  self = [super init];
  if (self) {
    _path = [[NSBundle mainBundle] pathForResource:@"photos" ofType:@"plist"];
    _photoList = [NSDictionary dictionaryWithContentsOfFile:_path];
  }
  return self;
}

- (NSUInteger)numberOfCategories {
  return [self.photoList allKeys].count;
}

- (NSString *)nameForCategory:(NSUInteger)category {
  NSArray *tempArray = [self.photoList allKeys];
  tempArray = [tempArray sortedArrayUsingSelector:@selector(compare:)];
  return [tempArray objectAtIndex:category];
}

- (NSUInteger)numberOfPhotosInCategory:(NSUInteger)category {
  NSArray *values = [self.photoList objectForKey:[self nameForCategory:category]];
  return values.count;
}

- (NSString *)nameForPhotoInCategory:(NSUInteger)category atPosition:(NSUInteger)position {
  NSString *keyName = [self nameForCategory:category];
  NSDictionary *photoKeys = [self.photoList objectForKey:keyName];
  NSArray *photos = [photoKeys allKeys];
  photos = [photos sortedArrayUsingSelector:@selector(compare:)];
  return photos[position];
}

- (UIImage *)imageForPhotoInCategory:(NSUInteger)category atPosition:(NSUInteger)position {
  NSString *keyName = [self nameForCategory:category];
  NSDictionary *photoKeys = [self.photoList objectForKey:keyName];
  NSArray *photos = [photoKeys allKeys];
  photos = [photos sortedArrayUsingSelector:@selector(compare:)];
  NSString *photoName = photos[position];
  UIImage *photoImage = [UIImage imageNamed:[photoKeys objectForKey:photoName]];
  return photoImage;
}

@end
