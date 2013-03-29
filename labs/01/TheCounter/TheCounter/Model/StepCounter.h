//
//  StepCounter.h
//  TheCounter
//
//  Created by Chris Hansen on 2/7/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Counter.h"

@interface StepCounter : Counter

@property (nonatomic, readonly) NSInteger stepAmount;

- (id)initWithInitialCount:(NSInteger)initialCount
                stepAmount:(NSInteger)stepAmount;

@end
