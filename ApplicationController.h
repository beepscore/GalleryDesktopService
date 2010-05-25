//
// IPHONE AND COCOA DEVELOPMENT AUSP10
//	
//  ApplicationController.m
//	HW7
//
//  portions Copyright 2010 Chris Parrish
//  portions Copyright Beepscore LLC 2010. All rights reserved.
//
//  App controller is a singleton object
//  This class conforms to two IKImageBrowserView informal protocols: 
//  IKImageBrowserDataSource and IKImageBrowserDelegate.

#import <Cocoa/Cocoa.h>

// import ImageShareService.h to see the ImageShareServiceProtocol declaration
#import "ImageShareService.h"

@class IKImageBrowserView;

// declare ApplicationController implements ImageShareServiceProtocol
@interface ApplicationController : NSObject <ImageShareServiceProtocol>
{
	NSTextView*				logTextField_;
	ImageShareService*		imageShareService_;
	
	IKImageBrowserView*		imageBrowser_;
	NSSlider*				zoomSlider_;
	
    // MVC Model object
	NSMutableArray*			images_;
    
    NSProgressIndicator* progressIndicator;
}
// Apple recommends on Mac assign IBOutlet, on iPhone retain IBOutlet
// applies only to nib top-level objects?
@property (nonatomic, assign) IBOutlet NSTextView*			logTextField;
@property (nonatomic, assign) IBOutlet IKImageBrowserView*	imageBrowser;
@property (nonatomic, assign) IBOutlet NSSlider*			zoomSlider;

@property(nonatomic, assign)IBOutlet NSProgressIndicator *progressIndicator;

+ (ApplicationController*)sharedApplicationController;

- (void) startService;
- (void) appendStringToLog:(NSString*)logString;

- (IBAction)	sendImage:(id)sender;
- (IBAction)	addImages:(id)sender;
- (IBAction)	zoomChanged:(id)sender;


@end
