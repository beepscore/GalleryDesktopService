//
// IPHONE AND COCOA DEVELOPMENT AUSP10
//	
//  FilePathImageObject.m
//	HW7
//
//  Copyright 2010 Chris Parrish
//
// A simple data object that holds an image path
// used by Image Kit Browser data source


#import "FilePathImageObject.h"
#import <Quartz/Quartz.h>

@implementation FilePathImageObject


- (void) dealloc
{
	// BE SURE TO CLEAN UP HERE!
	
	[super dealloc];
}

#pragma mark -
#pragma mark IKImageBrowserItem

// These methods implement the informal protocol
// required for objects returned by a IKImageBrowswerDataSource

// You need to implement each of these 

/*
- (NSString*)  imageRepresentationType
{
}

- (id)  imageRepresentation
{
}

- (id) imageTitle
{
}

- (NSString *) imageUID
{

}
*/

@end
