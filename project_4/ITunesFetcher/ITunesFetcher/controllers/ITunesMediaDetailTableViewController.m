//
//  ITunesMediaDetailTableViewController.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 4/7/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "ITunesMediaDetailTableViewController.h"

@interface ITunesMediaDetailTableViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *navTitle;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *iconSpinner;
@property (weak, nonatomic) IBOutlet UIImageView *appIcon;
@property (weak, nonatomic) IBOutlet UILabel *appTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *appArtistLabel;
@property (weak, nonatomic) IBOutlet UILabel *appButtonLabel;
@property (weak, nonatomic) IBOutlet UIButton *appPriceButton;

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *releasedLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *textViewCell;

@property (strong, nonatomic) UITextView *summaryTextView;

@end

@implementation ITunesMediaDetailTableViewController

#define NUMBER_OF_SECTIONS  2
#define FIRST_SECTION_ROWS  3
#define SECOND_SECTION_ROWS 1

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.navTitle.title = self.mediaItem.title;
  
  self.appTitleLabel.text = self.mediaItem.title;
  self.appArtistLabel.text = self.mediaItem.artist;
  self.appButtonLabel.text = self.mediaItem.price;
  
  self.rankLabel.text = [[NSString alloc] initWithFormat:@"%d", self.mediaItem.rank + 1];
  self.categoryLabel.text = self.mediaItem.category;
  self.releasedLabel.text = self.mediaItem.releaseDate;
  
  self.summaryTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 60, 100)];
  self.summaryTextView.delegate = self;
  [self.textViewCell.contentView addSubview:self.summaryTextView];
  if (self.mediaItem.summary) {
    self.summaryTextView.text = self.mediaItem.summary;
    [self.summaryTextView setFrame:CGRectMake(20, 20, self.view.frame.size.width - 60, self.summaryTextView.contentSize.height)];
    
  } else {
    self.summaryTextView.text = @"No summary available";
  }
  self.summaryTextView.userInteractionEnabled = NO;
  self.summaryTextView.scrollEnabled = NO;
  self.summaryTextView.bounces = NO;
  self.summaryTextView.bouncesZoom = NO;
  self.summaryTextView.backgroundColor = [[UIColor alloc] initWithWhite:0 alpha:0];
  
  if (self.mediaItem.artworkImage) {
    self.appIcon.image = self.mediaItem.artworkImage;
  } else {
    [self.iconSpinner startAnimating];
    dispatch_queue_t imageQ = dispatch_queue_create("Image Queue", NULL);
    dispatch_async(imageQ, ^{
      UIImage *tmpImage = [self.mediaItem getImage];
      dispatch_async(dispatch_get_main_queue(), ^{
        self.appIcon.image = tmpImage;
        [self.iconSpinner stopAnimating];
      });
    });
  }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return NUMBER_OF_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (section == 1) {
    return SECOND_SECTION_ROWS;
  } else {
    return FIRST_SECTION_ROWS;
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1) {
    return self.summaryTextView.contentSize.height + 30;
  }
  return 44;
}


- (IBAction)shareButton:(UIButton *)sender {
  NSString *summaryClip = [[NSString alloc] initWithFormat:@"%@...", [self.mediaItem.summary substringToIndex:100]];
  UIActivityViewController *sharingController;
  if (self.mediaItem.artworkImage) {
    sharingController = [[UIActivityViewController alloc] initWithActivityItems:@[self.mediaItem.title, self.mediaItem.storeURL, self.mediaItem.artworkImage, summaryClip] applicationActivities:nil];
  } else {
    sharingController = [[UIActivityViewController alloc] initWithActivityItems:@[self.mediaItem.title, self.mediaItem.storeURL, summaryClip] applicationActivities:nil];
  }
  [self presentViewController:sharingController animated:YES completion:nil];
}

- (IBAction)priceButton:(UIButton *)sender {
  NSURL *storeURL = [[NSURL alloc] initWithString:self.mediaItem.storeURL];
  UIApplication *thisApp = [UIApplication sharedApplication];
  [thisApp openURL:storeURL];
}

@end
