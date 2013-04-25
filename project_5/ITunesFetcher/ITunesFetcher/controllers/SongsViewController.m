//
//  SongsViewController.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/17/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "SongsViewController.h"
#import "ITunesMediaDetailTableViewController.h"

@interface SongsViewController ()

@property (nonatomic, strong) NSArray *mediaItems;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation SongsViewController

#define SONGS_TYPE 1

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.refreshControl addTarget:self
                          action:@selector(refresh)
                forControlEvents:UIControlEventValueChanged];
  dispatch_queue_t fetchQ = dispatch_queue_create("image queue", NULL);
  dispatch_async(fetchQ, ^{
    self.mediaItems = [self fetchMediaWithType:SONGS_TYPE];
    dispatch_async(dispatch_get_main_queue(), ^{
      if (!self.mediaItems) {
        UIAlertView *networkAlert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"A network connection cannot be detected.  Please confirm you have a network connection and try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [networkAlert show];
      }
      [self.table reloadData];
    });
  });
}

- (IBAction)refresh {
  [self.refreshControl beginRefreshing];
  dispatch_queue_t q = dispatch_queue_create("table view refresh", NULL);
  dispatch_async(q, ^{
    self.mediaItems = [self fetchMediaWithType:SONGS_TYPE];
    dispatch_async(dispatch_get_main_queue(), ^{
      if (!self.mediaItems) {
        UIAlertView *networkAlert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:@"A network connection cannot be detected.  Please confirm you have a network connection and try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [networkAlert show];
      }
      [self.table reloadData];
      [self.refreshControl endRefreshing];
    });
  });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  ITunesMediaDetailTableViewController *nextController = segue.destinationViewController;
  ITunesMediaItem *mediaItem = [self.mediaItems objectAtIndex:[self.table indexPathForCell:sender].row];
  nextController.mediaItem = mediaItem;
}

@end
