//
// IPHONE AND COCOA DEVELOPMENT AUSP10
//	
//  ApplicationController.m
//	HW7
//
//  Copyright 2010 Chris Parrish
//
//  App controller is a singleton object

#import <Cocoa/Cocoa.h>

@class ImageShareService;
@class IKImageBrowserView;

@interface ApplicationController : NSObject
{
	NSTextView*				logTextField_;
	ImageShareService*		imageShareService_;
	
	IKImageBrowserView*		imageBrowser_;
	NSSlider*				zoomSlider_;
	
	NSMutableArray*			images_;
}

@property (nonatomic, assign) IBOutlet NSTextView*			logTextField;
@property (nonatomic, assign) IBOutlet IKImageBrowserView*	imageBrowser;
@property (nonatomic, assign) IBOutlet NSSlider*			zoomSlider;

+ (ApplicationController*)sharedApplicationController;

- (void) startService;
- (void) appendStringToLog:(NSString*)logString;

- (IBAction)	sendImage:(id)sender;
- (IBAction)	addImages:(id)sender;
- (IBAction)	zoomChanged:(id)sender;


@end
