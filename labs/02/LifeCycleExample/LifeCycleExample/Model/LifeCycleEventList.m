//
//  LifeCycleEventList.m
//  LifeCycleExample
//
//  Created by Chris Hansen on 2/14/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "LifeCycleEventList.h"
#import "LifeCycleEvent.h"

@interface LifeCycleEventList()

@property (strong, nonatomic) NSMutableArray *eventList;

@end

@implementation LifeCycleEventList

- (id)init {
  self = [super init];
  if (self) {
    if (!_eventList) {
    _eventList = [[NSMutableArray alloc] init];
    }
  }
  return self;
}

- (void)addEventWithName:(NSString *)name {
  [self.eventList addObject:[[LifeCycleEvent alloc] initWithName:name]];
  NSLog(@"Added event, list looks like %@", self.eventList);
}

- (void)clearEvents {
  [self.eventList removeAllObjects];
}

- (NSArray *)allEvents {
  NSArray *tmp = self.eventList;
  return tmp;
}

@end
