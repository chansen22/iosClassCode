//
//  LifeCycleEvent.h
//  LifeCycleExample
//
//  Created by Chris Hansen on 2/14/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LifeCycleEvent : NSObject

@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSDate *date;

- (id)init;

- (id)initWithName:(NSString *)name;

@end
