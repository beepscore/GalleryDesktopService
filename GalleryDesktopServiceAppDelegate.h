//
// IPHONE AND COCOA DEVELOPMENT AUSP10
//	
//  DesktopServiceAppDelegate.h
//	HW7
//
//  portions Copyright 2010 Chris Parrish
//  portions Copyright Beepscore LLC 2010. All rights reserved.
//
// Desktop application that will
// advertise a network service available via bonjour

#import <Cocoa/Cocoa.h>

@class ApplicationController;


@interface GalleryDesktopServiceAppDelegate : NSObject <NSApplicationDelegate>
{
    NSWindow*				window;
	ApplicationController*  appController_;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet ApplicationController* appController;
@end
