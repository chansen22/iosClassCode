//
//  MoviesViewController.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/17/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "MoviesViewController.h"
#import "ITunesMediaItemDetailViewController.h"

@interface MoviesViewController ()

@property (nonatomic, strong) NSArray *topMovies;
@property (nonatomic, weak) IBOutlet UITableView *table;

@end

@implementation MoviesViewController

#define MOVIES_TYPE 3

- (void)viewDidLoad
{
  [super viewDidLoad];
  dispatch_queue_t fetchQ = dispatch_queue_create("image queue", NULL);
  dispatch_async(fetchQ, ^{
    self.topMovies = [self fetchMediaWithType:MOVIES_TYPE];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.table reloadData];
    });
  });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  ITunesMediaItemDetailViewController *nextController = segue.destinationViewController;
  ITunesMediaItem *mediaItem = [self.topMovies objectAtIndex:[self.table indexPathForCell:sender].row];
  nextController.mediaItem = mediaItem;
}

@end
