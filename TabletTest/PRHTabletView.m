#import "PRHTabletView.h"


@implementation PRHTabletView

- (void) viewDidMoveToWindow {
	[self.window setAcceptsMouseMovedEvents:YES];
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

@end