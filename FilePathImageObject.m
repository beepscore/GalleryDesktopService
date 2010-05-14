//
// IPHONE AND COCOA DEVELOPMENT AUSP10
//	
//  FilePathImageObject.m
//	HW7
//
//  portions Copyright 2010 Chris Parrish
//  portions Copyright Beepscore LLC 2010. All rights reserved.
//
// A simple data object that holds an image path
// used by Image Kit Browser data source


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

// These methods implement the informal protocol
// required for objects returned by a IKImageBrowswerDataSource

// You need to implement each of these 

- (NSString*)  imageRepresentationType
{
    return IKImageBrowserPathRepresentationType;
}


- (id)  imageRepresentation
{
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


@end
