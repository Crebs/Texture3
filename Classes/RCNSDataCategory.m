//
//  RCNSDataCategory.m
//  Texture3
//
//  Created by rcrebs on 10/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RCNSDataCategory.h"
#import "RCNSStringCategory.h"

@implementation NSData (DataForFileName)

+ (NSData*)findTextDataForImageNamed:(NSString*)imageName {
	
	NSString *path = [[NSBundle mainBundle] pathForResource:[imageName baseFileName] ofType:[imageName pathExtension]];
	return [[NSData alloc] initWithContentsOfFile:path];
	
}

@end
