@interface PRHTabletView : NSView

@property(weak) IBOutlet NSTextField *absoluteXField, *absoluteYField, *absoluteZField;
@property(weak) IBOutlet NSButton *tipButtonPressedBox, *lowerSideButtonPressedBox, *upperSideButtonPressedBox;
@property(weak) IBOutlet NSTextField *rotationField, *tiltXField, *tiltYField;
@property(weak) IBOutlet NSSlider *rotationSlider, *tiltXSlider, *tiltYSlider;
@property(weak) IBOutlet NSTextField *pressureField;
@property(weak) IBOutlet NSSlider *pressureSlider;
@property(weak) IBOutlet NSMatrix *pointingDeviceTypeRadio;

@end
