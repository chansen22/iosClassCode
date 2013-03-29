//
//  PolygonViewController.m
//  DrawPolygons
//
//  Created by Chris Hansen on 2/21/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "PolygonViewController.h"
#import "PolygonView.h"

@interface PolygonViewController ()

@property (strong, nonatomic)PolygonView *polyView;

@end

@implementation PolygonViewController

- (IBAction)polygonSlider:(UISlider *)sender {
}

- (void)updatePolygon {
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  [self.polyView setRadius:5];
}

@end
