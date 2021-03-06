//
// IPHONE AND COCOA DEVELOPMENT AUSP10
//	
//  FilePathImageObject.h
//	HW7
//
//  portions Copyright 2010 Chris Parrish
//  portions Copyright Beepscore LLC 2010. All rights reserved.
//
//  This class conforms to IKImageBrowserView's informal protocol IKImageBrowserItem
//  IKImageBrowserItem is a simple data object that holds an image path for use by IKImageBrowserDataSource
//  Ref http://17.254.2.129/mac/library/documentation/GraphicsImaging/Reference/IKImageBrowserItem_Protocol/IKImageBrowserItem_Reference.html#//apple_ref/doc/uid/TP40004709

#import <Foundation/Foundation.h>


@interface FilePathImageObject : NSObject

// DECLARE ANY PROPERTY OR IVARS YOU NEED
// TO MANAGE YOUR IMAGE MODEL
// I SUGGEST A SIMPLE NSSTRING FOR THE FILE PATH
{
#pragma mark instance variables
    NSString *filePath;
}

#pragma mark properties
@property(nonatomic,retain)NSString *filePath;

@end
