//
//  AppDelegate.m
//  JCNotePad
//
//  Created by Jesse Crocker on 8/10/12.
//  Copyright (c) 2012 Jesse Crocker. All rights reserved.
//

#import "AppDelegate.h"

#import "JCNotePadViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.noteViewController = [[JCNotePadViewController alloc] initWithNibName:@"JCNotePadViewController" bundle:nil];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.noteViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
