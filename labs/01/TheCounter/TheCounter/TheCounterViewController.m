//
//  TheCounterViewController.m
//  TheCounter
//
//  Created by Chris Hansen on 2/7/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "TheCounterViewController.h"
#import "StepCounter.h"

@interface TheCounterViewController ()
@property (weak, nonatomic) IBOutlet UILabel *oneXLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoXLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeXLabel;
@property (nonatomic) StepCounter *counter;
@property (nonatomic) StepCounter *counterByTwo;
@property (nonatomic) StepCounter *counterByThree;
@end

@implementation TheCounterViewController

- (void)updateUI {
  [self updateCounterLabels];
}

- (void)updateCounterLabels {
  int oneCount = self.counter.currentCount;
  int twoCount = self.counterByTwo.currentCount;
  int threeCount = self.counterByThree.currentCount;
  self.oneXLabel.text = [NSString stringWithFormat:@"%d", oneCount];
  self.twoXLabel.text = [NSString stringWithFormat:@"%d", twoCount];
  self.threeXLabel.text = [NSString stringWithFormat:@"%d", threeCount];
  if (oneCount < 0) {
    self.oneXLabel.textColor = [UIColor redColor];
  } else if (oneCount >= 0 && oneCount <= 10) {
    self.oneXLabel.textColor = [UIColor blackColor];
  } else if (oneCount > 10 && oneCount < 20) {
    self.oneXLabel.textColor = [UIColor greenColor];
  } else if (oneCount >= 20) {
    self.oneXLabel.textColor = [UIColor blueColor];
  }
  if (twoCount < 0) {
    self.twoXLabel.textColor = [UIColor redColor];
  } else if (twoCount >= 0 && twoCount < 10) {
    self.twoXLabel.textColor = [UIColor blackColor];
  } else if (twoCount >= 10 && twoCount < 20) {
    self.twoXLabel.textColor = [UIColor greenColor];
  } else if (twoCount >= 20) {
    self.twoXLabel.textColor = [UIColor blueColor];
  }
  if (threeCount < 0) {
    self.threeXLabel.textColor = [UIColor redColor];
  } else if (threeCount >= 0 && threeCount < 10) {
    self.threeXLabel.textColor = [UIColor blackColor];
  } else if (threeCount >= 10 && threeCount < 20) {
    self.threeXLabel.textColor = [UIColor greenColor];
  } else if (threeCount >= 20) {
    self.threeXLabel.textColor = [UIColor blueColor];
  }
}

- (StepCounter *)counter {
  if (!_counter) _counter = [[StepCounter alloc] initWithInitialCount:0 stepAmount:1];
  return _counter;
}

- (StepCounter *)counterByTwo {
  if (!_counterByTwo) _counterByTwo = [[StepCounter alloc] initWithInitialCount:0 stepAmount:2];
  return _counterByTwo;
}

- (StepCounter *)counterByThree {
  if (!_counterByThree) _counterByThree = [[StepCounter alloc] initWithInitialCount:0 stepAmount:3];
  return _counterByThree;
}

- (IBAction)incrementButton:(UIButton *)sender {
  [self.counter increment];
  [self.counterByTwo increment];
  [self.counterByThree increment];
  [self updateUI];
}

- (IBAction)decrementButton:(UIButton *)sender {
  [self.counter decrement];
  [self.counterByTwo decrement];
  [self.counterByThree decrement];
  [self updateUI];
}

- (IBAction)resetButton:(UIButton *)sender {
  [self.counter reset];
  [self.counterByTwo reset];
  [self.counterByThree reset];
  [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
