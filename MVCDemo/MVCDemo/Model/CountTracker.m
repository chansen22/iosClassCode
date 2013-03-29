//
//  CountTracker.m
//  MVCDemo
//
//  Created by Chris Hansen on 2/5/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "CountTracker.h"

@implementation CountTracker

- (void)increment {
    self.currentCount++;
}


- (void)decrement {
    self.currentCount--;
}

@end
