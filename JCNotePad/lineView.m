//
//  lineView.m
//  PitPod
//
//  Created by Jesse Crocker on 1/4/12.
//  Copyright (c) 2012 Thisside.net. All rights reserved.
//

#import "lineView.h"

@implementation lineView
@synthesize lineSpacing;
@synthesize topSkip;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    int width = rect.size.width;
    int height = rect.size.height;
    CGContextBeginPath (context);
    CGContextSetCMYKStrokeColor(context, 45.0/255, 20.0/255, 0.0/255, 10.0/255, 1.0);
    //draw horizontal lines
    int i = 0;
    for (i = topSkip; i < height; i += lineSpacing) {
        CGContextMoveToPoint(context, 0, i);
        CGContextAddLineToPoint(context, width, i);
    }
    //draw vertical lines
    //for (i = 0; i < width; i += gridSize) {
      //  CGContextMoveToPoint(context, i, 0);
        //CGContextAddLineToPoint(context, i, height);
    //}
    CGContextStrokePath(context);
}

@end
