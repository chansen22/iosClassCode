//
//  SongsViewController.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/17/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "SongsViewController.h"
#import "ITunesMediaItemDetailViewController.h"

@interface SongsViewController ()

@property (nonatomic, strong) NSArray *topSongs;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation SongsViewController

#define SONGS_TYPE 1

- (void)viewDidLoad {
  [super viewDidLoad];
  dispatch_queue_t fetchQ = dispatch_queue_create("image queue", NULL);
  dispatch_async(fetchQ, ^{
    self.topSongs = [self fetchMediaWithType:SONGS_TYPE];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.table reloadData];
    });
  });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  ITunesMediaItemDetailViewController *nextController = segue.destinationViewController;
  ITunesMediaItem *mediaItem = [self.topSongs objectAtIndex:[self.table indexPathForCell:sender].row];
  nextController.mediaItem = mediaItem;
}

@end
