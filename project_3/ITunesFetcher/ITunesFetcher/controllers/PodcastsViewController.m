//
//  PodcastsViewController.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/17/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "PodcastsViewController.h"
#import "ITunesMediaItemDetailViewController.h"

@interface PodcastsViewController ()

@property (strong, nonatomic) NSArray *topPodcasts;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation PodcastsViewController

#define PODCASTS_TYPE 5

- (void)viewDidLoad
{
  [super viewDidLoad];
  dispatch_queue_t fetchQ = dispatch_queue_create("image queue", NULL);
  dispatch_async(fetchQ, ^{
    self.topPodcasts = [self fetchMediaWithType:PODCASTS_TYPE];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.table reloadData];
    });
  });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  ITunesMediaItemDetailViewController *nextController = segue.destinationViewController;
  ITunesMediaItem *mediaItem = [self.topPodcasts objectAtIndex:[self.table indexPathForCell:sender].row];
  nextController.mediaItem = mediaItem;
}

@end
