//
//  ImageViewController.m
//  FlicrPicr
//
//  Created by Chris Hansen on 3/7/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ImageViewController

- (void)setImageUrl:(NSURL *)imageUrl {
  _imageUrl = imageUrl;
  
  [self resetImage];
}

- (void)resetImage {
  if (self.scrollView) {
    self.scrollView.contentSize = CGSizeZero;
    self.imageView.image = Nil;
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.imageUrl];
    
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    if (image) {
      self.scrollView.contentSize = image.size;
      self.scrollView.zoomScale = 1;
      self.imageView.image = image;
      self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    }
  }
}

- (UIImageView *)imageView {
  if (!_imageView) {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  }
  
  return _imageView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.scrollView addSubview:self.imageView];
  
  self.scrollView.minimumZoomScale = .2;
  self.scrollView.maximumZoomScale = 5;
  self.scrollView.delegate = self;
  
  [self resetImage];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return self.imageView;
}

@end