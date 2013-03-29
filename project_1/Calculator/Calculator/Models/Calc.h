//
//  Calc.h
//  Calculator
//
//  Created by Chris Hansen on 2/12/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calc : NSObject
@property (readonly, nonatomic) BOOL hasError;
@property (strong, nonatomic) NSNumber *memoryValue;
@property (strong, nonatomic) NSNumber *currentValue;
@property (strong, nonatomic) NSNumber *currentOperator;

- (id)init;
- (void)clear;
- (void)clearMemory;

- (NSString *)getOpByCharacter;
- (NSNumber *)calculate:(NSNumber *)withNumber;

@end
