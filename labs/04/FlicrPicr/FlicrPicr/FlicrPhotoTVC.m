//
//  FlicrPhotoTVC.m
//  FlicrPicr
//
//  Created by Chris Hansen on 3/7/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "FlicrPhotoTVC.h"
#import "FlickrFetcher.h"

@interface FlicrPhotoTVC ()

@end

@implementation FlicrPhotoTVC

- (void)setPhotos:(NSArray *)photos {
  _photos = photos;
  
  [self.tableView reloadData];
}

- (NSString *)titleForRow:(NSUInteger)row {
  return [self.photos[row][FLICKR_PHOTO_TITLE] description];
}

- (NSString *)subtitleForRow:(NSUInteger)row {
  return [self.photos[row][FLICKR_PHOTO_OWNER] description];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Flicr Photo";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
  cell.textLabel.text = [self titleForRow:indexPath.row];
  cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
  
  return cell;
}

@end
