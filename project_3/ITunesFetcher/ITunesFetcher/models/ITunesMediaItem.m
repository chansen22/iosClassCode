//
//  ITunesMediaItem.m
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/17/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "ITunesMediaItem.h"
#import "ITunesFetcherData.h"

@interface ITunesMediaItem()

@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *category;
@property (nonatomic, readwrite) NSString *artist;
@property (nonatomic, readwrite) NSString *releaseDate;
@property (nonatomic, readwrite) NSString *price;
@property (nonatomic, readwrite) NSURL    *artworkURL;
@property (nonatomic, readwrite) UIImage  *artworkImage;
@property (nonatomic, readwrite) NSString *storeURL;
@property (nonatomic, readwrite) int      rank;

@end

@implementation ITunesMediaItem

#define JANUARY   1
#define FEBRUARY  2
#define MARCH     3
#define APRIL     4
#define MAY       5
#define JUNE      6
#define JULY      7
#define AUGUST    8
#define SEPTEMBER 9
#define OCTOBER   10
#define NOVEMBER  11
#define DECEMBER  12

- (id)init {
  return nil;
}

- (id)initWithJSONAttributes:(NSDictionary *)jsonAttributes rank:(int)rank {
  self = [super init];
  if (self) {
    _rank = rank;
    _title = jsonAttributes[@"im:name"][@"label"];
    _category = jsonAttributes[@"category"][@"attributes"][@"label"];
    _artist = jsonAttributes[@"im:artist"][@"label"];
    _releaseDate = [self makeWordsFromDate:jsonAttributes[@"im:releaseDate"][@"label"]];
    _price = jsonAttributes[@"im:price"][@"label"];
    
    if (jsonAttributes[@"im:image"]) {
      int pictureIndex = 0;
      if (jsonAttributes[@"im:image"][2]) {
        //checking if there's a high res version of app icon
        pictureIndex = 2;
      }
        
      _artworkURL = jsonAttributes[@"im:image"][pictureIndex][@"label"];
      dispatch_queue_t getImageQ = dispatch_queue_create("get images", NULL);
      dispatch_async(getImageQ, ^{
        NSURL *tmpURL = [[NSURL alloc] initWithString:(NSString *)_artworkURL];
        ITunesFetcherData *sharedManager = [ITunesFetcherData sharedManager];
        [sharedManager incrementActivityCounter];
        NSData *tmpImageData = [[NSData alloc] initWithContentsOfURL:tmpURL];
        [sharedManager decrementActivityCounter];
        _artworkImage = [UIImage imageWithData:tmpImageData];
      });
    } else {
      _artworkImage = [UIImage imageNamed:@"1364371582_App_A.png"];
    }
    
    if ([jsonAttributes[@"link"] isKindOfClass:[NSArray class]]) {
      _storeURL = jsonAttributes[@"link"][0][@"attributes"][@"href"];
    } else {
      _storeURL = jsonAttributes[@"link"][@"attributes"][@"href"];
    }
  }
  return self;
}

- (NSString *)makeWordsFromDate:(NSString *)date {
  NSString *finalWords = @"";
  NSString *yearString = [NSString stringWithFormat:@"%@",
                          [date substringWithRange:NSMakeRange(0, 4)]];
  NSString *monthString = [NSString stringWithFormat:@"%@",
                           [date substringWithRange:NSMakeRange(5, 2)]];
  NSString *dayString = [NSString stringWithFormat:@"%@",
                         [date substringWithRange:NSMakeRange(8, 2)]];
  
  switch ([monthString integerValue]) {
    case JANUARY:
      monthString = @"January";
      break;
      
    case FEBRUARY:
      monthString = @"February";
      break;
    case MARCH:
      monthString = @"March";
      break;
    case APRIL:
      monthString = @"April";
      break;
    case MAY:
      monthString = @"May";
      break;
    case JUNE:
      monthString = @"June";
      break;
    case JULY:
      monthString = @"July";
      break;
    case AUGUST:
      monthString = @"August";
      break;
    case SEPTEMBER:
      monthString = @"September";
      break;
    case OCTOBER:
      monthString = @"October";
      break;
    case NOVEMBER:
      monthString = @"November";
      break;
    default:
      monthString = @"December";
      break;
  }
  return finalWords = [NSString stringWithFormat:@"%@ %@, %@", monthString, dayString, yearString];
}

@end
