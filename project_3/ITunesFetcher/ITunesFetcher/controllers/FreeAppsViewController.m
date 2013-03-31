//
//  FreeAppsViewController.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/17/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "FreeAppsViewController.h"
#import "ITunesMediaItemDetailViewController.h"

@interface FreeAppsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSArray *mediaItems;

@end

@implementation FreeAppsViewController

#define FREE_APPS_TYPE 0

- (void)viewDidLoad {
  [super viewDidLoad];
  dispatch_queue_t fetchQ = dispatch_queue_create("image queue", NULL);
  dispatch_async(fetchQ, ^{
    self.mediaItems = [self fetchMediaWithType:FREE_APPS_TYPE];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.table reloadData];
    });
  });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  ITunesMediaItemDetailViewController *nextController = segue.destinationViewController;
  ITunesMediaItem *mediaItem = [self.mediaItems objectAtIndex:[self.table indexPathForCell:sender].row];
  nextController.mediaItem = mediaItem;
}

@end
