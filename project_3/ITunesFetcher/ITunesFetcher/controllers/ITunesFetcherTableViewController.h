//
//  ITunesFetcherTableViewController.h
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/28/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITunesFetcherTableViewController : UITableViewController

- (NSArray *)fetchMediaWithType:(int)typeOfMedia;

@end
