//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Chris Hansen on 2/11/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "CalculatorViewController.h"
#import "Calc.h"

@interface CalculatorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatorLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *calcButtons;
@property (strong, nonatomic) Calc *calc;

@property (nonatomic) int opCount;
@property (nonatomic) BOOL writeOverLabel;

@end

@implementation CalculatorViewController

- (Calc *)calc {
  if (!_calc) {
    _calc = [[Calc alloc] init];
  }
  return _calc;
}

- (void)updateOP:(NSString *)newString {
  self.operatorLabel.text = [NSString stringWithFormat:@"%@", newString];
}

- (void)updateUI:(NSString *)newString {
  if ([newString isEqualToString:@"-0"]) {
    self.totalLabel.text = [NSString stringWithFormat:@"%d", (0)];
  } else if (self.writeOverLabel || [self.totalLabel.text isEqual:@"0"]) {
    self.totalLabel.text = [NSString stringWithFormat:@"%@", newString];
  } else {
    self.totalLabel.text = [NSString stringWithFormat:@"%@%@", self.totalLabel.text, newString];
  }
  self.writeOverLabel = NO;
}

- (void)setupValues:(UIButton *)sender {
  [self.calc setCurrentValue:[NSNumber numberWithDouble:[self.totalLabel.text doubleValue]]];
  [self.calc setCurrentOperator:[NSNumber numberWithInt:[sender tag]]];
  [self updateOP:[self.calc getOpByCharacter]];
  self.writeOverLabel = YES;
}

- (void)clear {
  [self.calc clear];
  self.opCount = 0;
  self.writeOverLabel = YES;
  [self updateUI:[NSString stringWithFormat:@"0"]];
  [self updateOP:[NSString stringWithFormat:@""]];
  self.writeOverLabel = YES;
}

- (void)hasError {
  [self clear];
  self.writeOverLabel = YES;
  [self updateUI:[NSString stringWithFormat:@"Not a number"]];
  self.writeOverLabel = YES;
}

- (BOOL)checkOpCount:(UIButton *)sender {
  if (self.opCount == 0) {
    [self setupValues:sender];
    self.opCount++;
    return YES;
  } else {
    return NO;
  }
}

- (IBAction)numberButton:(UIButton *)sender {
  NSNumber *tag = [NSNumber numberWithInt:sender.tag];
  [self updateUI:[NSString stringWithFormat:@"%@", tag]];
}

- (IBAction)periodButton:(UIButton *)sender {
  NSString *currentValue;
  if (!self.writeOverLabel) {
    if ([self.totalLabel.text rangeOfString:@"."].location == NSNotFound) {
      currentValue = [NSString stringWithFormat:@"%@.", self.totalLabel.text];
    } else {
      return;
    }
  } else {
    currentValue = [NSString stringWithFormat:@"0."];
  }
  self.writeOverLabel = YES;
  [self updateUI:[NSString stringWithFormat:@"%@", currentValue]];
}

- (IBAction)plusMinusButton:(UIButton *)sender {
  if ([self.totalLabel.text isEqualToString:@"0"] || [self.totalLabel.text isEqualToString:@"."]) {
    self.writeOverLabel = YES;
  } else {
    NSNumber *currentNumber = [NSNumber numberWithDouble:[self.totalLabel.text doubleValue]];
    currentNumber = [NSNumber numberWithDouble:[currentNumber doubleValue] * -1];
    [self.calc setCurrentValue:currentNumber];
    self.writeOverLabel = YES;
    [self updateUI:[NSString stringWithFormat:@"%g", [currentNumber doubleValue]]];
    self.writeOverLabel = YES;
  }
}

- (IBAction)equalButton:(UIButton *)sender {
  if (self.opCount > 0) {
    NSNumber *result = [self.calc calculate:[NSNumber numberWithDouble:[self.totalLabel.text doubleValue]]];
    if ([self.calc hasError]) {
      [self hasError];
    } else {
      [self clear];
      [self.calc setCurrentOperator:[NSNumber numberWithInt:(0)]];
      [self.calc setCurrentValue:result];
      self.opCount = 0;
      self.writeOverLabel = YES;
      [self updateUI:[NSString stringWithFormat:@"%g", [result doubleValue]]];
      self.writeOverLabel = YES;
    }
  }
}

- (IBAction)normalOperators:(UIButton *)sender {
  if (![self checkOpCount:sender]) {
    NSNumber *result = [self.calc calculate:[NSNumber numberWithDouble:[self.totalLabel.text doubleValue]]];
    if ([self.calc hasError]) {
      [self hasError];
    } else {
      [self.calc setCurrentOperator:[NSNumber numberWithInt:[sender tag]]];
      self.writeOverLabel = YES;
      [self updateUI:[NSString stringWithFormat:@"%g", [result doubleValue]]];
      [self updateOP:[self.calc getOpByCharacter]];
      self.writeOverLabel = YES;
    }
  }
}

- (IBAction)oneStepOperators:(UIButton *)sender {
  if (![self checkOpCount:sender]) {
    NSNumber *result = [self.calc calculate:[NSNumber numberWithDouble:[self.totalLabel.text doubleValue]]];
    if ([self.calc hasError]) {
      [self hasError];
    } else {
      [self.calc setCurrentValue:[NSNumber numberWithDouble:[result doubleValue]]];
      [self.calc setCurrentOperator:[NSNumber numberWithInt:[sender tag]]];
      NSNumber *oneStepResult = [self.calc calculate:[NSNumber numberWithDouble:[self.totalLabel.text doubleValue]]];
      self.opCount = 0;
      self.writeOverLabel = YES;
      [self updateUI:[NSString stringWithFormat:@"%g", [oneStepResult doubleValue]]];
      [self updateOP:[NSString stringWithFormat:@"%@", [self.calc getOpByCharacter]]];
      self.writeOverLabel = YES;
    }
  }
}

- (IBAction)memoryAddButton:(UIButton *)sender {
  [self.calc setMemoryValue:[NSNumber numberWithDouble:[self.totalLabel.text doubleValue]]];
}

- (IBAction)memoryRememberButton:(UIButton *)sender {
  [self updateUI:[NSString stringWithFormat:@"%@", [self.calc memoryValue]]];
}

- (IBAction)memoryClearButton:(UIButton *)sender {
  [self.calc setMemoryValue:[NSNumber numberWithDouble:(0)]];
}

- (IBAction)clearButton:(UIButton *)sender {
  [self clear];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.writeOverLabel = YES;
  self.opCount = 0;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
