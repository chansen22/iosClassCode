//
//  HawaiiImageViewController.m
//  FlicrPicr
//
//  Created by Chris Hansen on 3/7/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "HawaiiImageViewController.h"
#define IMAGE_URL @"http://images.apple.com/v/iphone/gallery/a/images/photo_3.jpg"

@interface HawaiiImageViewController ()

@end

@implementation HawaiiImageViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.imageUrl = [[NSURL alloc] initWithString:IMAGE_URL];
}

@end
