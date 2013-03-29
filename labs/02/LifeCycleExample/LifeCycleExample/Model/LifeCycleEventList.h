//
//  LifeCycleEventList.h
//  LifeCycleExample
//
//  Created by Chris Hansen on 2/14/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LifeCycleEventList : NSObject

- (void)addEventWithName:(NSString *)name;
- (void)clearEvents;

- (NSArray *)allEvents;

@end
