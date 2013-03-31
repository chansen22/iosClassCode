//
//  ITunesFetcherData.h
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/27/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITunesFetcherData : NSObject

@property (nonatomic)NSInteger *activityIndicatorCount;

+ (ITunesFetcherData *)sharedManager;

- (void)incrementActivityCounter;
- (void)decrementActivityCounter;

@end
