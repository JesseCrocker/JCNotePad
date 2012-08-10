//
//  JCNotePadViewController.h
//
//  Created by Jesse Crocker on 3/6/12.
//  Copyright (c) 2012 Jess Crocker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "lineView.h"

@interface JCNotePadViewController : UIViewController
@property ( nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet lineView *lines;
@property (nonatomic) NSManagedObject *objectToSet;
@property (nonatomic) NSString *fieldToSet;
@property (nonatomic) UIBarButtonItem *doneButton;
@property (assign) bool readOnly;

- (void) liftMainViewWhenKeybordAppears:(NSNotification*)aNotification;
- (void) returnMainViewToInitialposition:(NSNotification*)aNotification;
- (IBAction)doneButtonPressed;

-(CGRect)rectSwap:(CGRect)rect;


@end
