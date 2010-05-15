//
// IPHONE AND COCOA DEVELOPMENT AUSP10
//	
//  ApplicationController.m
//	HW7
//
//  portions Copyright 2010 Chris Parrish
//  portions Copyright Beepscore LLC 2010. All rights reserved.
//

#import "ApplicationController.h"
#import "ImageShareService.h"
#import "FilePathImageObject.h"
#import <Quartz/Quartz.h>


#pragma mark Static
static ApplicationController*		sharedApplicationController = nil;

@interface ApplicationController ()

- (void) addImagesFromDirectory:(NSString*) path;
- (void) addImagesFromDirectory:(NSString *)path atIndex:(NSUInteger)index;
- (void) addImageWithPath:(NSString *)path atIndex:(NSUInteger)index;
- (void) addImageWithPath:(NSString *)path;


@end

@implementation ApplicationController

@synthesize logTextField = logTextField_;
@synthesize imageBrowser = imageBrowser_;
@synthesize zoomSlider = zoomSlider_;

#pragma mark Singleton
// Note : This is how Apple recommends implementing a singleton class :

+ (ApplicationController*)sharedApplicationController
{
    if (sharedApplicationController == nil)
	{
        sharedApplicationController = [[super allocWithZone:NULL] init];
    }
    return sharedApplicationController;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedApplicationController] retain];
}


- (id) init
{
	self = [super init];
	if (self != nil)
	{

	}
	return self;
}

- (void) dealloc
{
	[images_ release];
	[super dealloc];
}

-(void) awakeFromNib
{
    // Setup the browser with some default images that should be installed on the system
    images_ = [[NSMutableArray alloc] init];

    // add images from application bundle
    NSString* baileyPath = [[NSBundle mainBundle] pathForResource:@"baileySit100514" ofType:@"jpg"];    
    [self addImageWithPath:baileyPath];
    NSString *lavaPath = [[NSBundle mainBundle] pathForResource:@"Lava" ofType:@"jpg"];
    [self addImageWithPath:lavaPath];
    
    // add images from library
    [self addImagesFromDirectory:@"/Library/Desktop Pictures/"];   
    
    // sync browser zoom to slider
    [self.imageBrowser setZoomValue:[self.zoomSlider floatValue]];

	// Make sure the image browser allows reordering
	[self.imageBrowser setAllowsReordering:YES];
    [self.imageBrowser setAnimates:YES];
	
	// TODO: HW_TODO: 
	//SETUP THE STYLE OF THE BROWSER CELLS HERE
	//ANYTHING YOU LIKE, SHADOWS, TITLES, ETC
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

#pragma mark -
#pragma mark Service

- (void) appendStringToLog:(NSString*)logString
{
	NSString* newString = [NSString stringWithFormat:@"%@\n", logString];
	[[[logTextField_ textStorage] mutableString] appendString: newString];
}

- (void) startService
{
	imageShareService_ = [[ImageShareService alloc] init];
	[imageShareService_ startService];
	[imageShareService_ publishService];
}


#pragma mark -
#pragma mark Adding Images

- (void) addImageWithPath:(NSString *)path
{
	[self addImageWithPath:path atIndex:[images_ count]];
}


- (void) addImageWithPath:(NSString *)path atIndex:(NSUInteger)index
{   
	// THIS IS WHERE WE CREATE NEW MODEL OBJECTS
	
	// skip hidden directories and files
	NSString* filename = [path lastPathComponent];
	
	if([filename length] > 0)
	{		
        // L denotes a wide-character literal
		if ( [filename characterAtIndex:0] == L'.')
			return;	
	}

	// Check if this path is a directory. If it is, recursively add each file in it
	BOOL isDirectory = NO;
	[[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
	
	if (isDirectory)
	{
		[self addImagesFromDirectory:path atIndex:index];
		return;
	}	
	
	// otherwise add just this file
	// create a new model object and add it to images_
    FilePathImageObject* tempFilePathImageObject = [[FilePathImageObject alloc] init];
    tempFilePathImageObject.filePath = path;
    [images_ addObject:tempFilePathImageObject];
    [tempFilePathImageObject release];
    
    // We changed the model so make sure the image browser reloads its data
    // This message was in addImagesFromDirectory:, which calls addImageWithPath: methods.
    // Move here so it gets sent when calling addImageWithPath: alone
	[imageBrowser_ reloadData];
}


- (void) addImagesFromDirectory:(NSString *) path
{
	[self addImagesFromDirectory:path atIndex:[images_ count]];
}


- (void) addImagesFromDirectory:(NSString *)path atIndex:(NSUInteger)index
{	
	// YOU CAN USE THIS CODE AS IS OR REPLACE IF YOU WANT TO DO IT DIFFERENTLY
	
    int i, n;
    BOOL dir;
	
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&dir];
    
    if(dir)
	{
        NSArray *content = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
		
        n = [content count];
        
        for(i=0; i<n; i++)
			[self addImageWithPath:[path stringByAppendingPathComponent:[content objectAtIndex:i]] atIndex:index];
    }
    else 
    {
        [self addImageWithPath:path];        
    }
}


#pragma mark -
#pragma mark Actions

- (IBAction) sendImage:(id)sender
{
	// Use the imageBrowser selection to get a model object (FilePathImageObject)
    
    NSIndexSet* selectedImages = [self.imageBrowser selectionIndexes];

    // if no images were selected, don't try to send an image
    if (0 == selectedImages.count)
    {
        NSLog(@"No image selected");
        return;
    }
    
    // select only the first image in the set.
    NSUInteger selectedImageIndex = [selectedImages firstIndex];

    // defensive programming- check index is within images_ array bounds
    // ref http://stackoverflow.com/questions/771185/cocoa-objective-c-array-beyond-bounds-question
    if (0 <= selectedImageIndex && [images_ count] > selectedImageIndex)
    {
        // get the model object
        FilePathImageObject* selectedFilePathImageObject = [images_ objectAtIndex:selectedImageIndex];
        
        // Create NSImage using the model object's filePath
        NSImage* image = [[NSImage alloc] initWithContentsOfFile:selectedFilePathImageObject.filePath];
        
        NSLog(@"selectedImageIndex = %d  selectedFilePath = %@",
              selectedImageIndex, selectedFilePathImageObject.filePath);
        
        // send NSImage
        [imageShareService_ sendImageToClients:image];
        [image release];        
    }
}

- (IBAction) addImages:(id)sender
{
    // Create a standard open file panel and add the results	
    NSOpenPanel* panel;
	
    panel = [NSOpenPanel openPanel];        

    [panel setFloatingPanel:YES];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:YES];
	
	NSInteger buttonPressed = [panel runModal];
	
	if( buttonPressed == NSOKButton )
	{
		NSArray* filePaths = [panel filenames];
		for (NSString* filePath in filePaths)
		{
			[self addImagesFromDirectory:filePath];
		}
    }    
}


- (IBAction) zoomChanged:(id)sender
{
    [self.imageBrowser setZoomValue:[sender floatValue]];
}


#pragma mark -
#pragma mark IKImageBrowserDataSource
// Implement IKImageBrowserView's informal protocol IKImageBrowserDataSource
// Our datasource representation is a simple mutable array

- (NSUInteger) numberOfItemsInImageBrowser:(IKImageBrowserView *) view
{
    // return the number of images in the model
    // [[view visibleItemIndexes] count] only counts visible items?
    NSLog(@"numberOfItemsInImageBrowser = %d", [images_ count]);
    return [images_ count];
}

- (id) imageBrowser:(IKImageBrowserView *) aBrowser itemAtIndex:(NSUInteger)index;

{
	// HW_TODO :
    // RETURN THE IMAGE MODEL OBJECT AT THE GIVEN INDEX
    return [images_ objectAtIndex:index];
}

- (void) imageBrowser:(IKImageBrowserView *)view removeItemsAtIndexes:(NSIndexSet *)indexes
{
    [images_ removeObjectsAtIndexes:indexes];
}

- (BOOL) imageBrowser:(IKImageBrowserView *)view  moveItemsAtIndexes:(NSIndexSet *)indexes toIndex:(NSUInteger)destinationIndex
{
	NSUInteger index;
	NSMutableArray* temporaryArray;
	
	temporaryArray = [[[NSMutableArray alloc] init] autorelease];
	
	// remove items from the end working our way back to the first item
	// this keeps the indexs we haven't moved yet from shifting to a new position
	// before we get to them
	for( index = [indexes lastIndex];
		 index != NSNotFound;
		 index = [indexes indexLessThanIndex:index] )
	{
		if (index < destinationIndex)
			destinationIndex--;
		
		FilePathImageObject* image = [images_ objectAtIndex:index];
		[temporaryArray addObject:image];
		[images_ removeObjectAtIndex:index];
	}
	
	// Insert at the new destination
	int n = [temporaryArray count];
	for( index = 0; index < n; index++)
	{
		[images_ insertObject:[temporaryArray objectAtIndex:index]
					  atIndex:destinationIndex];
	}
	
	return YES;
}


#pragma mark -
#pragma mark IKImageBrowserDelegate
// Implement IKImageBrowserView's informal protocol IKImageBrowserDelegate

- (void) imageBrowser:(IKImageBrowserView *) aBrowser cellWasDoubleClickedAtIndex:(NSUInteger) index
{
	// HW_TODO :
	// TREAT A DOUBLE CLICK AS A SEND OF THE IMAGE
	// INSTEAD OF THE DEFAULT TO OPEN
	
}


#pragma mark -
#pragma mark  Drag and Drop
// Conform to NSDraggingDestination informal protocol
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
	return [self draggingUpdated:sender];
}


- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
	if ([sender draggingSource] == imageBrowser_) 
		return NSDragOperationMove;
	
    return NSDragOperationCopy;
}


- (BOOL) performDragOperation:(id <NSDraggingInfo>)sender
{
    NSData*		data				= nil;
    NSString*	errorDescription	= nil;
    
	// if we are dragging from the browser itself, ignore it
	if ([sender draggingSource] == imageBrowser_) 
		return NO;
	
    NSPasteboard* pasteboard = [sender draggingPasteboard];
    
    if ([[pasteboard types] containsObject:NSFilenamesPboardType])
	{
        data = [pasteboard dataForType:NSFilenamesPboardType];

        NSArray* filePaths = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:kCFPropertyListImmutable format:nil errorDescription:&errorDescription];		
		
		
		for (NSString* filePath in filePaths)
		{
			[self addImageWithPath:filePath atIndex:[imageBrowser_ indexAtLocationOfDroppedItem]];
		}
	
		[imageBrowser_ reloadData];
    }	
	return YES;
}

@end





