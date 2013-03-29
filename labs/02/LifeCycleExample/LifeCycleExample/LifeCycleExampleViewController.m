//
//  LifeCycleExampleViewController.m
//  LifeCycleExample
//
//  Created by Chris Hansen on 2/14/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "LifeCycleExampleViewController.h"
#import "LifeCycleEventList.h"

@interface LifeCycleExampleViewController ()

@property (weak, nonatomic) IBOutlet UITextView *lifeCycleLabel;

@property (strong, nonatomic) LifeCycleEventList *lifeCycleEventList;

@end

@implementation LifeCycleExampleViewController

- (LifeCycleEventList *)lifeCycleEventList {
  if (_lifeCycleEventList) {
    _lifeCycleEventList = [[LifeCycleEventList alloc] init];
  }
  return _lifeCycleEventList;
}

- (void)updateUI {
  NSString *tmp;
  for (NSArray *event in [self.lifeCycleEventList allEvents]) {
    tmp = [NSString stringWithFormat:@"%@\n%@", tmp, event];
  }
  self.lifeCycleLabel.text = tmp;
}

- (IBAction)clearButton:(UIButton *)sender {
  [self.lifeCycleEventList clearEvents];
  [self updateUI];
}

- (void)awakeFromNib {
  [self.lifeCycleEventList addEventWithName:@"awakeFromNib"];
  [self updateUI];
}

- (void)viewWillAppear:(BOOL)animated {
  
}

- (void)viewDidAppear:(BOOL)animated {
  
}

- (void)viewWillLayoutSubviews {
  
}

- (void)viewDidLayoutSubviews {
  
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  
}

- (void)viewWillDisappear:(BOOL)animated {
  
}

- (void)viewDidDisappear:(BOOL)animated {
  
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
