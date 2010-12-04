//
//  RCNSStringCategory.m
//  Texture3
//
//  Created by rcrebs on 10/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RCNSStringCategory.h"


@implementation NSString (RCNSStringCategory)

-(NSString*)baseFileName {
	NSString *extension = [self pathExtension];
	NSString *baseFilenameWithExtension = [self lastPathComponent];
	return [baseFilenameWithExtension substringToIndex:[baseFilenameWithExtension length] - [extension length] - 1];
}

/********************************************************************
 * Ignore cases sensitivity and see if letters are the same
 *******************************************************************/
-(BOOL)isSameStringAs:(NSString*) stringName {
	return [[self lowercaseString] isEqualToString:stringName];
}
@end
