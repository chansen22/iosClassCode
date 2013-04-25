//
//  ITunesMediaDetailTableViewController.h
//  ITunesFetcher
//
//  Created by Christopher Hansen on 4/7/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITunesMediaItem.h"

@interface ITunesMediaDetailTableViewController : UITableViewController

@property (nonatomic, strong) ITunesMediaItem *mediaItem;

@end
