//
//  lineView.h
//  PitPod
//
//  Created by Jesse Crocker on 1/4/12.
//  Copyright (c) 2012 Thisside.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface lineView : UIView{
    NSUInteger lineSpacing;
    NSUInteger topSkip;
}
@property (assign) NSUInteger lineSpacing;
@property (assign) NSUInteger topSkip;
@end
