//
// IPHONE AND COCOA DEVELOPMENT AUSP10
//	
//  FilePathImageObject.h
//	HW7
//
//  portions Copyright 2010 Chris Parrish
//  portions Copyright Beepscore LLC 2010. All rights reserved.
//
// An IKImageBrowserItem, a simple data object that holds an image path
// used by Image Kit Browser data source

#import <Foundation/Foundation.h>


@interface FilePathImageObject : NSObject
{
#pragma mark instance variables
    NSString *filePath;
}

// DECLARE ANY PROPERTY OR IVARS YOU NEED
// TO MANAGE YOUR IMAGE MODEL
// I SUGGEST A SIMPLE NSSTRING FOR THE FILE PATH
#pragma mark -
#pragma mark properties
@property(nonatomic,retain)NSString *filePath;


@end
