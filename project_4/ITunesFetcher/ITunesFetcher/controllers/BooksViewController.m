//
//  BooksViewController.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/17/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "BooksViewController.h"
#import "ITunesMediaDetailTableViewController.h"

@interface BooksViewController ()

@property (strong, nonatomic) NSArray *mediaItems;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation BooksViewController

#define BOOKS_TYPE 4

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.refreshControl addTarget:self
                          action:@selector(refresh)
                forControlEvents:UIControlEventValueChanged];
  dispatch_queue_t fetchQ = dispatch_queue_create("image queue", NULL);
  dispatch_async(fetchQ, ^{
    self.mediaItems = [self fetchMediaWithType:BOOKS_TYPE];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.table reloadData];
    });
  });
}

- (IBAction)refresh {
  [self.refreshControl beginRefreshing];
  dispatch_queue_t q = dispatch_queue_create("table view refresh", NULL);
  dispatch_async(q, ^{
    self.mediaItems = [self fetchMediaWithType:BOOKS_TYPE];
    dispatch_async(dispatch_get_main_queue(), ^{
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
