//
//  PRHTabletWindowController.m
//  TabletTest
//
//  Created by Peter Hosey on 2012-11-14.
//  Copyright (c) 2012 Peter Hosey. All rights reserved.
//

#import "PRHTabletWindowController.h"

@interface PRHTabletWindowController ()

@end

@implementation PRHTabletWindowController

- (instancetype) initWithWindow:(NSWindow *)window {
	self = [super initWithWindow:window];
	if (self) {
		// Initialization code here.
	}

	return self;
}

- (instancetype) init {
	return [self initWithWindowNibName:[self className]];
}

- (void) windowDidLoad {
	[super windowDidLoad];

}

- (void) tabletPoint:(NSEvent *)event {
	NSLog(@"%s", __func__);
}

@end
