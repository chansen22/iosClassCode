//
//  SpeedUpViewController.m
//  SpeedUp
//
//  Created by Chris Morris on 3/14/13.
//  Copyright (c) 2013 CSU Chico. All rights reserved.
//

#import "SpeedUpViewController.h"

#define PHOTO_PLIST_FILE @"image_urls"

@interface SpeedUpViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *photoList;
@property (nonatomic) int netorkActivityCounter;

@end

@implementation SpeedUpViewController

- (NSArray *)photoList
{
  if (!_photoList) {
    NSString *path = [[NSBundle mainBundle] pathForResource:PHOTO_PLIST_FILE ofType:@"plist"];
    
    _photoList = [[NSArray alloc] initWithContentsOfFile:path];
    _netorkActivityCounter = 0;
  }
  
  return _photoList;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  NSUInteger photoCount   = [self.photoList count];
  CGSize     viewableSize = self.scrollView.frame.size;
  
  self.scrollView.contentSize = CGSizeMake(viewableSize.width * photoCount, viewableSize.height);
  
  dispatch_queue_t imageQ = dispatch_queue_create("image queue", NULL);
  
  for (int photoIndex = 0; photoIndex < photoCount; photoIndex++) {
    NSURL  *currentPhotoURL = [[NSURL alloc] initWithString:self.photoList[photoIndex]];
    
    CGRect imageFrame = CGRectMake(viewableSize.width * photoIndex,
                                   0,
                                   viewableSize.width,
                                   viewableSize.height);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithFrame:imageFrame];
    spinner.hidesWhenStopped = YES;
    spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.scrollView addSubview:spinner];
    [spinner startAnimating];
    
    //        dispatch_queue_t imageQ = dispatch_queue_create("image queue", NULL);
    
    // NOTE: You are not allowed to remove or change the call to sleep
    //       It must always preceed your NSData call in order to simulate a delay
    dispatch_async(imageQ, ^{
      [self incrementNetworkActivityCounter];
      [NSThread sleepForTimeInterval:2.0];
      
      NSData  *imageData = [[NSData alloc] initWithContentsOfURL:currentPhotoURL];
      [self decrementNetworkActivityCounter];
      dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *image     = [UIImage imageWithData:imageData];
        
        imageView.image = image;
        [spinner stopAnimating];
        
        [self.scrollView addSubview:imageView];
      });
    });
  }
}

- (void)incrementNetworkActivityCounter {
  self.netorkActivityCounter++;
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)decrementNetworkActivityCounter {
  self.netorkActivityCounter--;
  if (self.netorkActivityCounter == 0) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  }
}

@end
