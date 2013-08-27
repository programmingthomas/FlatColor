//
//  FCAppDelegate.m
//  FlatColor
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "FCAppDelegate.h"

@implementation FCAppDelegate

- (IBAction)createAction:(id)sender
{
    float width = self.widthField.floatValue;
    float height = self.heightField.floatValue;
    NSColor * color = self.colorWell.color;
    NSSavePanel * savePanel = [NSSavePanel savePanel];
    [savePanel setAllowedFileTypes:@[@"png"]];
    [savePanel setAllowsOtherFileTypes:NO];
    if ([savePanel runModal] == NSFileHandlingPanelOKButton)
    {
        [[NSOperationQueue new] addOperationWithBlock:^{
            [self generateToFile:[savePanel URL] width:width height:height color:color];
            if (self.generateRetina.state == NSOnState)
            {
                NSString * fileUrlString = [[[savePanel URL] filePathURL] absoluteString];
                fileUrlString = [fileUrlString stringByReplacingOccurrencesOfString:@".png" withString:@"@2x.png"];
                NSURL * retinaUrl = [NSURL URLWithString:fileUrlString];
                [self generateToFile:retinaUrl width:width * 2 height:height * 2 color:color];
            }
        }];
    }
}

-(void)generateToFile:(NSURL*)fileUrl width:(float)width height:(float)height color:(NSColor*)color
{
    NSImage * image = [[NSImage alloc] initWithSize:CGSizeMake(width, height)];
    [image lockFocus];
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, width, height));
    [image unlockFocus];
    NSData * imageData = [image TIFFRepresentation];
    NSBitmapImageRep * imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    imageData = [imageRep representationUsingType:NSPNGFileType properties:nil];
    NSError * error;
    [imageData writeToURL:fileUrl options:NSDataWritingAtomic error:&error];
    if (error)
    {
        NSLog(@"Failed to save %@ (%@)", [fileUrl absoluteString], error.localizedDescription);
    }
}

@end
