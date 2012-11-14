//
//  PRHAppDelegate.m
//  TabletTest
//
//  Created by Peter Hosey on 2012-11-14.
//  Copyright (c) 2012 Peter Hosey. All rights reserved.
//

#import "PRHAppDelegate.h"

#import "PRHTabletWindowController.h"

@implementation PRHAppDelegate
{
	PRHTabletWindowController *wc;
}

- (void) applicationWillFinishLaunching:(NSNotification *)notification {
	wc = [PRHTabletWindowController new];
	[wc showWindow:nil];
}
- (void) applicationWillTerminate:(NSNotification *)notification {
	[wc close];
	wc = nil;
}

@end
