//
//  ITunesFetcherData.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/27/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "ITunesFetcherData.h"

@implementation ITunesFetcherData

@synthesize activityIndicatorCount;

+ (ITunesFetcherData *)sharedManager {
  static id sharedManager;
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    sharedManager = [[self alloc] init];
  });
  return sharedManager;
}

- (void)incrementActivityCounter {
  self.activityIndicatorCount += 1;
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)decrementActivityCounter {
  self.activityIndicatorCount -= 1;
  if (self.activityIndicatorCount == 0) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  }
}

@end
