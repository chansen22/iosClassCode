//
//  CountTracker.h
//  MVCDemo
//
//  Created by Chris Hansen on 2/5/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountTracker : NSObject

@property (nonatomic) NSInteger currentCount;

- (void)increment;
- (void)decrement;

@end
