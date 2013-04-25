//
//  ITunesFetcherTableViewController.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/28/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "ITunesFetcherTableViewController.h"
#import "ITunesFetcher.h"
#import "ITunesMediaItem.h"
#import "ITunesMediaItemTableViewCell.h"
#import "ITunesMediaDetailTableViewController.h"

@interface ITunesFetcherTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *mediaItems;
@property (strong, nonatomic) ITunesMediaDetailTableViewController *nextController;
@property (nonatomic) int type;

@end

@implementation ITunesFetcherTableViewController

#define FREE_APPS_TYPE 0
#define SONGS_TYPE     1
#define I_TUNES_U_TYPE 2
#define MOVIES_TYPE    3
#define BOOKS_TYPE     4
#define PODCASTS_TYPE  5

- (NSArray *)fetchMediaWithType:(int)typeOfMedia {
  switch (typeOfMedia) {
    case FREE_APPS_TYPE:
      self.mediaItems = [ITunesFetcher topFreeApps];
      break;
    case SONGS_TYPE:
      self.mediaItems = [ITunesFetcher topSongs];
      break;
    case I_TUNES_U_TYPE:
      self.mediaItems = [ITunesFetcher topITunesUCourses];
      break;
    case MOVIES_TYPE:
      self.mediaItems = [ITunesFetcher topMovies];
      break;
    case BOOKS_TYPE:
      self.mediaItems = [ITunesFetcher topFreeBooks];
      break;
    case PODCASTS_TYPE:
      self.mediaItems = [ITunesFetcher topPodcasts];
      break;
    default:
      self.mediaItems = @[];
  }
  return self.mediaItems;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.mediaItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  dispatch_queue_t fetchQ = dispatch_queue_create("Image fetching", NULL);
  ITunesMediaItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell" forIndexPath:indexPath];
  ITunesMediaItem *mediaItem = [self.mediaItems objectAtIndex:indexPath.row];
  
  cell.titleLabel.text = mediaItem.title;
  cell.detailLabel.text = mediaItem.artist;
  cell.rankLabel.text = [NSString stringWithFormat:@"%d", [mediaItem.rank integerValue]+1];
  cell.iconImage.image = nil;
  
  // Loading images
  [cell.iconSpinner startAnimating];
  dispatch_async(fetchQ, ^{
    UIImage *tmpImage = [mediaItem getImage];
    dispatch_async(dispatch_get_main_queue(), ^{
      if (tmpImage) {
        ITunesMediaItemTableViewCell *oldCell = (ITunesMediaItemTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        oldCell.iconImage.image = tmpImage;
      }
      [cell.iconSpinner stopAnimating];
    });
  });
  
  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  self.nextController = segue.destinationViewController;
  ITunesMediaItem *mediaItem = [self.mediaItems objectAtIndex:[sender row]];
  self.nextController.mediaItem = mediaItem;
}

@end
