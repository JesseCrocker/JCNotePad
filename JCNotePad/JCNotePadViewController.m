//
//  JCNotePadViewController.m
//
//  Created by Jesse Crocker on 3/6/12.
//  Copyright (c) 2012 Jesse Crocker. All rights reserved.
//

#import "JCNotePadViewController.h"

@implementation JCNotePadViewController
@synthesize textView;
@synthesize lines;
@synthesize objectToSet;
@synthesize fieldToSet;
@synthesize doneButton;
@synthesize readOnly;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    textView.contentSize = textView.frame.size;
    
    self.lines.lineSpacing = 22;
    self.lines.topSkip = 26;
    [textView addSubview:self.lines];
    
    [textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    if(self.readOnly){
        textView.editable = NO;
    }else{
        textView.editable = YES;
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(doneButtonPressed)];
        self.doneButton = button;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(liftMainViewWhenKeybordAppears:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnMainViewToInitialposition:) name:UIKeyboardWillHideNotification object:nil];
    NSString *text = [objectToSet valueForKey:fieldToSet];
    if(text != nil)
        textView.text = text;
    else
        textView.text = @"";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
	[self.textView resignFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)dealloc {
    [textView removeObserver:self forKeyPath:@"contentSize"];
}

#pragma mark - resize view when keyboard opens
-(CGRect)rectSwap:(CGRect)rect{
	CGRect newRect;
	newRect.origin.x = rect.origin.y;
	newRect.origin.y = rect.origin.x;
	newRect.size.width = rect.size.height;
	newRect.size.height = rect.size.width;
	return newRect;
}

- (void) liftMainViewWhenKeybordAppears:(NSNotification*)aNotification{
    self.navigationItem.rightBarButtonItem = self.doneButton;
    
    NSDictionary* userInfo = [aNotification userInfo];
    
    NSValue* keyboardFrameValue = [userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    if (!keyboardFrameValue) {
        keyboardFrameValue = [userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    }
    
    CGRect windowRect = [[UIApplication sharedApplication] keyWindow].bounds;
    if (UIInterfaceOrientationLandscapeLeft == self.interfaceOrientation ||UIInterfaceOrientationLandscapeRight == self.interfaceOrientation ) {
        windowRect = [self rectSwap:windowRect];
    }
    CGRect viewRectAbsolute = [self.textView convertRect:self.textView.bounds toView:[[UIApplication sharedApplication] keyWindow]];
    if (UIInterfaceOrientationLandscapeLeft == self.interfaceOrientation ||UIInterfaceOrientationLandscapeRight == self.interfaceOrientation ) {
        viewRectAbsolute = [self rectSwap:viewRectAbsolute];
    }
    CGRect frame = self.textView.frame;
    frame.size.height -= [keyboardFrameValue CGRectValue].size.height - CGRectGetMaxY(windowRect) + CGRectGetMaxY(viewRectAbsolute);
    
    if (UIInterfaceOrientationLandscapeLeft == self.interfaceOrientation ||UIInterfaceOrientationLandscapeRight == self.interfaceOrientation ) {
        frame.size.height -= 50;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    self.textView.frame = frame;
    [UIView commitAnimations];
}

- (void) returnMainViewToInitialposition:(NSNotification*)aNotification{
    self.navigationItem.rightBarButtonItem = nil;
    CGRect newFrame = CGRectMake(0, 0, self.textView.frame.size.width, self.view.frame.size.height);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
    self.textView.frame = newFrame;
    [UIView commitAnimations];
}


- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	CGSize newSize = [[change objectForKey:@"new"] CGSizeValue];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        lines.frame = CGRectMake(lines.frame.origin.x, lines.frame.origin.y, newSize.width + 124.0, newSize.height + 1100.0);
    }else{
        lines.frame = CGRectMake(lines.frame.origin.x, lines.frame.origin.y, newSize.width + 124.0, newSize.height + 480.0);
    }
    [self.lines setNeedsLayout];
    [self.lines setNeedsDisplay];
}

#pragma mark - responding to userinput
- (IBAction)doneButtonPressed {
    [textView resignFirstResponder];
    [objectToSet setValue:textView.text forKey:fieldToSet];
}

@end
