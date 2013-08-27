//
//  FCAppDelegate.h
//  FlatColor
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FCAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *widthField;
@property (weak) IBOutlet NSTextField *heightField;
@property (weak) IBOutlet NSColorWell *colorWell;
@property (weak) IBOutlet NSButton *generateRetina;
- (IBAction)createAction:(id)sender;

@end
