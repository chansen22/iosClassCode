//
//  ITunesMediaItem.h
//  ITunesFetcher
//
//  Created by Christopher Hansen on 3/17/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITunesMediaItem : NSObject <NSCoding>

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *category;
@property (nonatomic, readonly) NSString *artist;
@property (nonatomic, readonly) NSString *releaseDate;
@property (nonatomic, readonly) NSString *price;
@property (nonatomic, readonly) NSString *summary;
@property (nonatomic, readonly) NSString *artworkURL;
@property (nonatomic, readonly) UIImage  *artworkImage;
@property (nonatomic, readonly) NSString *storeURL;
@property (nonatomic, readonly) NSNumber *rank;

- (id)initWithJSONAttributes:(NSDictionary *)jsonAttributes rank:(NSNumber *)rank;

- (UIImage *)getImage;

- (void)encodeWithCoder:(NSCoder *)aCoder;

@end
