//
//  GridViewController.m
//  Pickr
//
//  Created by Chris Hansen on 2/26/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "GridViewController.h"
#import "PhotoLibrary.h"
#import "PhotoCategoryReusableView.h"
#import "PhotoCollectionViewCell.h"

@interface GridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) PhotoLibrary *photoLibrary;

@property (weak, nonatomic) IBOutlet UILabel *imageNameLabel;

@end

@implementation GridViewController

- (PhotoLibrary *)photoLibrary {
  if (!_photoLibrary) {
    _photoLibrary = [[PhotoLibrary alloc] init];
  }
  return _photoLibrary;
}

// Protocol Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return [self.photoLibrary numberOfCategories];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [self.photoLibrary numberOfPhotosInCategory:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PhotoCollectionViewCell *cell;
  
  cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  [cell.photoCell setImage:[self.photoLibrary imageForPhotoInCategory:indexPath.section atPosition:indexPath.row]];
  return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  PhotoCategoryReusableView *reusableView;
  
  reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
  
  reusableView.sectionHeader.text = [self.photoLibrary nameForCategory:indexPath.section];
  return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  self.imageNameLabel.text = [self.photoLibrary nameForPhotoInCategory:indexPath.section atPosition:indexPath.row];
}

// End of protocol methods

@end
