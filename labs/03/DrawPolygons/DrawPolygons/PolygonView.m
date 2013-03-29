//
//  PolygonView.m
//  DrawPolygons
//
//  Created by Chris Hansen on 2/21/13.
//  Copyright (c) 2013 Chris Hansen. All rights reserved.
//

#import "PolygonView.h"

@implementation PolygonView
#define CORNER_RADIUS 12

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
  [roundedRect addClip];
  
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  
  [[UIColor redColor] setFill];
  
  UIBezierPath *polygonPath = [[UIBezierPath alloc] init];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, self.bounds.size.width / 2, self.bounds.size.height / 2);
  
  [polygonPath moveToPoint:CGPointMake([self radius], 0)];
  
  for (int i = 1; i < self.numberOfSides; i++) {
    CGFloat x = [self radius] * cos(2 * M_PI * i / self.numberOfSides);
    CGFloat y = [self radius] * sin(2 * M_PI * i / self.numberOfSides);
  }
}

@end