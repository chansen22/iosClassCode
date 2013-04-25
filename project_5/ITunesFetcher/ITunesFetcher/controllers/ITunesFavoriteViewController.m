//
//  ITunesFavoriteViewController.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 4/15/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "ITunesFavoriteViewController.h"
#import "ITunesFavorites.h"
#import "ITunesMediaItemTableViewCell.h"
#import "ITunesMediaDetailTableViewController.h"

@interface ITunesFavoriteViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *mediaItems;

@end

@implementation ITunesFavoriteViewController

- (void)viewWillAppear:(BOOL)animated {
  ITunesFavorites *favorites = [ITunesFavorites sharedFavoritesManager];
  self.mediaItems = [favorites allFavorites];
  [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  ITunesMediaDetailTableViewController *nextController = segue.destinationViewController;
  ITunesMediaItem *mediaItem = [self.mediaItems objectAtIndex:[self.tableView indexPathForCell:sender].row];
  nextController.mediaItem = mediaItem;
}

@end
