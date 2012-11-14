#import "PRHTabletView.h"


@implementation PRHTabletView
{
	NSPoint lastScribbledPoint;
	NSImage *lastEventTypeIcon;
	NSImage *eventTypeIconMouse, *eventTypeIconTablet;
}

- (void) viewDidMoveToWindow {
	[self.window setAcceptsMouseMovedEvents:YES];
}

- (bool) eventIsMouseEvent:(NSEvent *)event {
	NSEventType type = event.type;
	switch (type) {
		case NSLeftMouseDown:
		case NSLeftMouseUp:
		case NSRightMouseDown:
		case NSRightMouseUp:
		case NSMouseMoved:
		case NSLeftMouseDragged:
		case NSRightMouseDragged:
		case NSMouseEntered:
		case NSMouseExited:
			return true;
		default:
			return false;
	}
}
- (bool) eventIsTabletEvent:(NSEvent *)event {
	NSEventType type = event.type;
	switch (type) {
		case NSTabletPoint:
		case NSTabletProximity:
		    return true;
		default:
	        return false;
	}
}

- (NSRect) rectForImage:(NSImage *)image toBeDrawnCenteredAtPoint:(NSPoint)center {
	NSSize size = image.size;
	NSPoint origin = { lastScribbledPoint.x - size.width / 2.0, lastScribbledPoint.y - size.height / 2.0 };
	return (NSRect){ origin, size };
}

- (void) reportEvent:(NSEvent *)event {
	self.absoluteXField.integerValue = event.absoluteX;
	self.absoluteYField.integerValue = event.absoluteY;
	self.absoluteZField.integerValue = event.absoluteZ;

	self.tipButtonPressedBox.state = (bool)(event.buttonMask & NSPenTipMask);
	self.lowerSideButtonPressedBox.state = (bool)(event.buttonMask & NSPenLowerSideMask);
	self.upperSideButtonPressedBox.state = (bool)(event.buttonMask & NSPenUpperSideMask);

	self.rotationField.floatValue = self.rotationSlider.floatValue = event.rotation;
	self.tiltXField.doubleValue = self.tiltXSlider.doubleValue = event.tilt.x;
	self.tiltYField.doubleValue = self.tiltYSlider.doubleValue = event.tilt.y;

	self.pressureField.floatValue = self.pressureSlider.floatValue = event.tangentialPressure;

	[self.pointingDeviceTypeRadio selectCellAtRow:0 column:event.pointingDeviceType];

	if (!eventTypeIconMouse) {
		eventTypeIconMouse = [[NSImage alloc] initWithContentsOfFile:@"/System/Library/PreferencePanes/Mouse.prefPane/Contents/Resources/Mouse.icns"];
		eventTypeIconMouse.size = (NSSize){ 32.0, 32.0 };
	}
	if (!eventTypeIconTablet) {
		eventTypeIconTablet = [[NSImage alloc] initWithContentsOfFile:@"/System/Library/PreferencePanes/Ink.prefPane/Contents/Resources/Ink.icns"];
		eventTypeIconTablet.size = (NSSize){ 32.0, 32.0 };
	}

	if (lastEventTypeIcon) {
		[self setNeedsDisplayInRect:[self rectForImage:lastEventTypeIcon toBeDrawnCenteredAtPoint:lastScribbledPoint]];
	}

	lastScribbledPoint = [self convertPoint:event.locationInWindow fromView:nil];

	NSImage *newEventTypeIcon = [self eventIsMouseEvent:event] ? eventTypeIconMouse : [self eventIsTabletEvent:event] ? eventTypeIconTablet : nil;
	if (lastEventTypeIcon != newEventTypeIcon) {
		lastEventTypeIcon = newEventTypeIcon;

		if (lastEventTypeIcon) {
			[self setNeedsDisplayInRect:[self rectForImage:lastEventTypeIcon toBeDrawnCenteredAtPoint:lastScribbledPoint]];
		}
	}
}

- (void) tabletPoint:(NSEvent *)event {
	NSLog(@"%s", __func__);
	[self reportEvent:event];
}

- (void) tabletProximity:(NSEvent *)event {
	NSLog(@"%s", __func__);
	[self reportEvent:event];
}

- (void) mouseMoved:(NSEvent *)event {
	NSLog(@"%s: %hd", __func__, [event subtype]);
	[self reportEvent:event];
}
- (void) mouseDown:(NSEvent *)event {
	NSLog(@"%s: %hd", __func__, [event subtype]);
	[self reportEvent:event];
}
- (void) mouseDragged:(NSEvent *)event {
	NSLog(@"%s: %hd", __func__, [event subtype]);
	[self reportEvent:event];
}
- (void) mouseUp:(NSEvent *)event {
	NSLog(@"%s: %hd", __func__, [event subtype]);
	[self reportEvent:event];
}

- (void) drawRect:(NSRect)dirtyRect {
	NSRect destRect = [self rectForImage:lastEventTypeIcon toBeDrawnCenteredAtPoint:lastScribbledPoint];
	[lastEventTypeIcon drawInRect:destRect fromRect:NSZeroRect
	                    operation:NSCompositeSourceOver fraction:1.0];
}

@end