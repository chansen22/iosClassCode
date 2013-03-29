//
//  LifeCycleEvent.m
//  LifeCycleExample
//
//  Created by Chris Hansen on 2/14/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "LifeCycleEvent.h"

@interface LifeCycleEvent()

@property (readwrite, nonatomic) NSString *name;
@property (readwrite, nonatomic) NSDate *date;

@end

@implementation LifeCycleEvent

- (id)init {
  return [self initWithName:nil];
}

- (id)initWithName:(NSString *)name {
  self = [super init];
  if (self) {
    _name = name;
    _date = [NSDate date];
  }
  return self;
}

@end
