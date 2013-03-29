//
//  PickrViewController.m
//  Pickr
//
//  Created by Chris Hansen on 2/26/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "PickrViewController.h"
#import "PhotoLibrary.h"

@interface PickrViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *picturePicker;
@property (weak, nonatomic) IBOutlet UIImageView *pickerImageView;
@property (weak, nonatomic) IBOutlet UISlider *alphaSlider;

@property (strong, nonatomic) PhotoLibrary *photoLib;

@end

@implementation PickrViewController

- (PhotoLibrary *)photoLib {
  if (!_photoLib) {
    _photoLib = [[PhotoLibrary alloc] init];
  }
  return _photoLib;
}

- (IBAction)changeAlpha:(UISlider *)sender {
  self.alphaSlider.value = sender.value;
  [self.pickerImageView setAlpha:(sender.value/100)];
  //set alpha
}

//Picker Protocol Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  // Number of segments the picker is divided into
  return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  switch (component) {
    case 0:
      // The first segment of picker
      return [self.photoLib numberOfCategories];
      break;
      
      // Second Segment
    default:
      return [self.photoLib numberOfPhotosInCategory:[self.picturePicker selectedRowInComponent:0]];
      break;
  }
  return [self.photoLib numberOfPhotosInCategory:component];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  switch (component) {
    case 0:
      // First segment
      return [self.photoLib nameForCategory:row];
      break;
      
      // Second Segment
    default:
      return [self.photoLib nameForPhotoInCategory:[self.picturePicker selectedRowInComponent:0] atPosition:row];
      break;
  }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  switch (component) {
    case 0:
      [self.picturePicker selectRow:0 inComponent:1 animated:YES];
      [self.picturePicker reloadComponent:1];
      [self.picturePicker selectRow:0 inComponent:1 animated:YES];
      [self.pickerImageView setImage:[self.photoLib imageForPhotoInCategory:[self.picturePicker selectedRowInComponent:0] atPosition:0]];
      break;
      
    default:
      [self.pickerImageView setImage:[self.photoLib imageForPhotoInCategory:[self.picturePicker selectedRowInComponent:0] atPosition:row]];
      break;
  }
}

//End Picker Methods

- (void)viewDidLoad {
  [self.pickerImageView setImage:[self.photoLib imageForPhotoInCategory:(0) atPosition:(0)]];
}

@end
