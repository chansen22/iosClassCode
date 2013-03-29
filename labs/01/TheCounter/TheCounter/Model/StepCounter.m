//
//  StepCounter.m
//  TheCounter
//
//  Created by Chris Hansen on 2/7/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "StepCounter.h"

@implementation StepCounter

- (id)initWithInitialCount:(NSInteger)initialCount stepAmount:(NSInteger)stepAmount {
  self = [super initWithInitialCount:initialCount];
  if (self) {
    _stepAmount = stepAmount;
  }
  return self;
}

- (void)increment {
  self.currentCount = self.currentCount + self.stepAmount;
}

- (void)decrement {
  self.currentCount = self.currentCount - self.stepAmount;
}

@end
