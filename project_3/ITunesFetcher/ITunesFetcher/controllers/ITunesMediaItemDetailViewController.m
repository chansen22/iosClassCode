//
//  ITunesMediaItemDetailViewController.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/23/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "ITunesMediaItemDetailViewController.h"

@interface ITunesMediaItemDetailViewController () <UITableViewDataSource, UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *staticTable;
@property (weak, nonatomic) IBOutlet UIImageView *artworkImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;
@property (weak, nonatomic) IBOutlet UILabel *buttonLabel;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerTitleLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imageActivityIndicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;

@end

@implementation ITunesMediaItemDetailViewController

#define NUMBER_OF_SECTIONS 1
#define NUMBER_OF_ROWS 3

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.headerTitleLabel.title = self.mediaItem.title;
  self.titleLabel.text = self.mediaItem.title;
  self.artistLabel.text = self.mediaItem.artist;
  if (self.mediaItem.artworkImage) {
    self.artworkImage.image = self.mediaItem.artworkImage;
  } else {
    [self waitForImage];
  }
  self.buttonLabel.text = self.mediaItem.price;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return NUMBER_OF_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return NUMBER_OF_ROWS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
  if (indexPath.row == 0) {
    cell.textLabel.text = @"Rank";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", self.mediaItem.rank+1];
  }
  else if (indexPath.row == 1) {
    cell.textLabel.text = @"Category";
    cell.detailTextLabel.text = self.mediaItem.category;
  }
  else {
    cell.textLabel.text = @"Released";
    cell.detailTextLabel.text = self.mediaItem.releaseDate;
  }
  return cell;
}

- (void)waitForImage {
  // Start an activity indicator on imageview
  [self.imageActivityIndicator startAnimating];
  dispatch_queue_t waitForImageQ = dispatch_queue_create("wait for image q", NULL);
  dispatch_async(waitForImageQ, ^{
    while(!self.mediaItem.artworkImage) {
      [NSThread sleepForTimeInterval:.1];
    }
    self. artworkImage.image = self.mediaItem.artworkImage;
    [self.imageActivityIndicator stopAnimating];
  });
}

- (IBAction)shareButton:(UIButton *)sender {
  UIActivityViewController *sharingController = [[UIActivityViewController alloc] initWithActivityItems:@[self.mediaItem.title, self.mediaItem.storeURL, self.mediaItem.artworkImage] applicationActivities:nil];
  [self presentViewController:sharingController animated:YES completion:nil];
}

- (IBAction)priceButton:(UIButton *)sender {
  NSURL *storeURL = [[NSURL alloc] initWithString:self.mediaItem.storeURL];
  UIApplication *ourApp = [UIApplication sharedApplication];
  [ourApp openURL:storeURL];
}

@end
