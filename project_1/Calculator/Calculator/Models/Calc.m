//
//  Calc.m
//  Calculator
//
//  Created by Chris Hansen on 2/12/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "Calc.h"

@interface Calc()

@property (readwrite, nonatomic) BOOL hasError;

@end

@implementation Calc

- (id)init {
  self = [super init];
  if (self) {
    _hasError = NO;
    _currentOperator = [NSNumber numberWithInt:(0)];
    _memoryValue = [NSNumber numberWithDouble:(0)];
    _currentValue = [NSNumber numberWithDouble:(0)];
  }
  return self;
}

- (void)clear {
  self.currentValue = [NSNumber numberWithDouble:(0)];
  self.currentOperator = [NSNumber numberWithInt:(0)];
  self.hasError = NO;
}

- (void)clearMemory {
  self.memoryValue = [NSNumber numberWithDouble:(0)];
}

- (void)hadError {
  self.hasError = YES;
}

- (NSString *)getOpByCharacter {
  switch ([self.currentOperator integerValue]) {
    case 13:
      return [NSString stringWithFormat:@"+"];
      break;
    
    case 14:
      return [NSString stringWithFormat:@"-"];
      break;
      
    case 15:
      return [NSString stringWithFormat:@"*"];
      break;
      
    case 16:
      return [NSString stringWithFormat:@"/"];
      break;
      
    case 17:
      return [NSString stringWithFormat:@"√"];
      break;
      
    case 18:
      return [NSString stringWithFormat:@"1/x"];
      break;
      
    default:
      return @"";
      break;
  }
}

- (NSNumber *)calculate:(NSNumber *)withNumber {
  self.hasError = NO;
  switch ([self.currentOperator integerValue]) {
    case 13:
      // ADD
      return [self addCurrentNumberWith:withNumber];
      break;
    
    case 14:
      // Minus
      return [self minusCurrentNumberWith:withNumber];
      break;
      
    case 15:
      // Multiply
      return [self multiplyCurrentNumberWith:withNumber];
      break;
      
    case 16:
      // Divide
      if ([withNumber doubleValue] == 0) {
        [self hadError];
        return Nil;
      }
      return [self divideCurrentNumberWith:withNumber];
      break;
      
    case 17:
      // Square Root
      if ([self.currentValue doubleValue] < 0) {
        [self hadError];
        return Nil;
      }
      return [self squareRootCurrentNumber];
      break;
      
    case 18:
      // 1 / x
      if ([self.currentValue doubleValue] == 0) {
        [self hadError];
        return Nil;
      }
      return [self oneOverXCurrentNumber];
      break;
      
    default:
      return Nil;
      break;
  }
}

- (NSNumber *)addCurrentNumberWith:(NSNumber *)withNumber {
  NSNumber *result = [NSNumber numberWithDouble:[self.currentValue doubleValue] + [withNumber doubleValue]];
  [self setCurrentValue:result];
  return result;
}

- (NSNumber *)minusCurrentNumberWith:(NSNumber *)withNumber {
  NSNumber *result = [NSNumber numberWithDouble:[self.currentValue doubleValue] - [withNumber doubleValue]];
  [self setCurrentValue:result];
  return result;
}

- (NSNumber *)multiplyCurrentNumberWith:(NSNumber *)withNumber {
  NSNumber *result = [NSNumber numberWithDouble:[self.currentValue doubleValue] * [withNumber doubleValue]];
  [self setCurrentValue:result];
  return result;
}

- (NSNumber *)divideCurrentNumberWith:(NSNumber *)withNumber {
  NSNumber *result = [NSNumber numberWithDouble:[self.currentValue doubleValue] / [withNumber doubleValue]];
  [self setCurrentValue:result];
  return result;
}

- (NSNumber *)squareRootCurrentNumber {
  NSNumber *result = [NSNumber numberWithDouble:sqrt([self.currentValue doubleValue])];
  [self setCurrentValue:result];
  return result;
}

- (NSNumber *)oneOverXCurrentNumber {
  NSNumber *result = [NSNumber numberWithDouble:( 1 / [self.currentValue doubleValue])];
  [self setCurrentValue:result];
  return result;
}

@end
