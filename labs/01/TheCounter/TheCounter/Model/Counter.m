//
//  Counter.m
//  TheCounter
//
//  Created by Chris Hansen on 2/7/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "Counter.h"

@implementation Counter

- (id)initWithInitialCount:(NSInteger)initialCount {
  self = [super init];
  if (self) {
    self.currentCount = initialCount;
  }
  return self;
}

- (void)increment {
  _currentCount++;
}

- (void)decrement {
  _currentCount--;
}

- (void)reset {
  NSLog(@"Reset called");
  _currentCount = 0;
}

@end
