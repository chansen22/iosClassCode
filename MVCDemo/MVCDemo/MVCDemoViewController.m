//
//  MVCDemoViewController.m
//  MVCDemo
//
//  Created by Chris Hansen on 2/5/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "MVCDemoViewController.h"
#import "CountTracker.h"

@interface MVCDemoViewController ()
@property (nonatomic, weak) IBOutlet UILabel *topCountLabel;
@property (nonatomic) CountTracker *topTracker;
@end

@implementation MVCDemoViewController

- (IBAction)incrementTopCounter:(UIButton *)sender {
    [self.topTracker increment];
    _topCountLabel.text = [NSString stringWithFormat:@"%d", self.topTracker.currentCount];
    NSLog(@"button clicked");
}

- (IBAction)decrementTopCounter:(UIButton *)sender {
    [self.topTracker decrement];
    _topCountLabel.text = [NSString stringWithFormat:@"%d", self.topTracker.currentCount];
    NSLog(@"button clicked");
    NSLog(@"Current count is %d", self.topTracker.currentCount);
}

- (CountTracker *)topTracker {
    if (!_topTracker) {
        _topTracker = [[CountTracker alloc] init];
    }
    return _topTracker;
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	// Do any additional setup after loading the view, typically from a nib.
//}

@end
