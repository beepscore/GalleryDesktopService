//
// IPHONE AND COCOA DEVELOPMENT AUSP10
//	
//  FilePathImageObject.m
//	HW7
//
//  portions Copyright 2010 Chris Parrish
//  portions Copyright Beepscore LLC 2010. All rights reserved.
//

#import "FilePathImageObject.h"
#import <Quartz/Quartz.h>

@implementation FilePathImageObject

#pragma mark -
#pragma mark properties
@synthesize filePath;

- (void) dealloc
{
	// BE SURE TO CLEAN UP HERE!
    [filePath release], filePath = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark IKImageBrowserItem
// Implement IKImageBrowserView's informal protocol IKImageBrowserItem

- (NSString*)  imageRepresentationType
{
    return IKImageBrowserPathRepresentationType;
}


- (id)  imageRepresentation
{
    // Returns the image to display
    return self.filePath;
}


- (id) imageTitle
{
    return self.filePath;
}

- (NSString *) imageUID
{
    // use filePath as a unique identifier for the image
    return self.filePath;
}
#pragma mark -

@end
