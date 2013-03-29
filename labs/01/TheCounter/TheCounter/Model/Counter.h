//
//  Counter.h
//  TheCounter
//
//  Created by Chris Hansen on 2/7/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Counter : NSObject

@property (nonatomic)NSInteger currentCount;

- (id)initWithInitialCount:(NSInteger)initialCount;

- (void)increment;

- (void)decrement;

- (void)reset;

@end
