//
// IPHONE AND COCOA DEVELOPMENT AUSP10
//	
//  ImageShareService.h
//	HW7
//
//  portions Copyright 2010 Chris Parrish
//  portions Copyright Beepscore LLC 2010. All rights reserved.
//
// Class that handles listening for incoming connections
// and then sending an image to the connected client

#import <Foundation/Foundation.h>

@class ApplicationController;

@interface ImageShareService : NSObject <NSNetServiceDelegate>
{
	
	ApplicationController*	appController_;
	
	CFSocketRef				socket_;
	NSFileHandle*			connectionFileHandle_;
	
	NSMutableDictionary*	dataForFileHandles_;
	
	NSMutableArray*			connectedFileHandles_;
}

- (BOOL) startService;
- (void) publishService;

- (void) handleIncomingConnection:(NSNotification*)notification;
- (void) stopReceivingForFileHandle:(NSFileHandle*)fileHandle closeFileHandle:(BOOL)close;
- (void) readIncomingData:(NSNotification*) notification;

- (void) sendImageToClients:(NSImage*)image;


@end
