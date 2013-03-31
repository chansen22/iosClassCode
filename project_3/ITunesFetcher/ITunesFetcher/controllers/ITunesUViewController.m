//
//  ITunesUViewController.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/17/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "ITunesUViewController.h"
#import "ITunesMediaItemDetailViewController.h"

@interface ITunesUViewController ()

@property (nonatomic, strong) NSArray *university;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ITunesUViewController

#define I_TUNES_U_TYPE 2

- (void)viewDidLoad
{
  [super viewDidLoad];
  dispatch_queue_t fetchQ = dispatch_queue_create("image queue", NULL);
  dispatch_async(fetchQ, ^{
    self.university = [self fetchMediaWithType:I_TUNES_U_TYPE];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.table reloadData];
    });
  });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  ITunesMediaItemDetailViewController *nextController = segue.destinationViewController;
  ITunesMediaItem *mediaItem = [self.university objectAtIndex:[self.table indexPathForCell:sender].row];
  nextController.mediaItem = mediaItem;
}

@end
