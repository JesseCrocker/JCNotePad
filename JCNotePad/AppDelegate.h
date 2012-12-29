//
//  AppDelegate.h
//  JCNotePad
//
//  Created by Jesse Crocker on 8/10/12.
//  Copyright (c) 2012 Jesse Crocker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCNotePadViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) JCNotePadViewController *noteViewController;

@end
