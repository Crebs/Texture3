//
//  OpenGLTexture3D.m
//  NeHe Lesson 06
//
//  Created by Jeff LaMarche on 12/24/08.
//  Copyright 2008 Jeff LaMarche Consulting. All rights reserved.
//

#import "OpenGLTexture3D.h"
#import "RCNSDataCategory.h"
#import "RCPlanetVertex.h"

static BOOL __generatedTextures = NO;

#pragma mark -
#pragma mark OpenGLTexture3D implementation
@implementation OpenGLTexture3D
@synthesize filename;
// Height and width are required for pvrt compressed textures. They will be ignored for images that can be used to create UIImage
//- (id)initWithFilename:(NSString *)inFilename width:(GLuint)inWidth height:(GLuint)inHeight;
//{
//	if ((self = [super init]))
//	{
//		glEnable(GL_TEXTURE_2D);
//		
//		self.filename = inFilename;
//		glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
//		
//		/***************************************************************
//		 * This may need to be moved
//		 *************************Below This****************************/
//		glGenTextures(1, &texture[0]);
//		glBindTexture(GL_TEXTURE_2D, texture[0]);
//		/*************************Above This****************************/
//		
//		//glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
//		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
//		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
//		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR); 
//		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR); 
//		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
//		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
//		glBlendFunc(GL_ONE, GL_SRC_COLOR);
//		
//		// Find the texture data from the file system
//		NSData *texData = [NSData findTextDataForImageNamed:inFilename];
//		
//		// Assumes pvr4 is RGB not RGBA, which is how texturetool generates them
//		if ([[inFilename pathExtension] isEqualToString:@"pvr4"])
//			glCompressedTexImage2D(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG, inWidth, inHeight, 0, (inWidth * inHeight) / 2, [texData bytes]);
//		else if ([[inFilename pathExtension] isEqualToString:@"pvr2"])
//			glCompressedTexImage2D(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG, inWidth, inHeight, 0, (inWidth * inHeight) / 2, [texData bytes]);
//		else
//		{
//			UIImage *image = [[UIImage alloc] initWithData:texData];
//			if (image == nil)
//				return nil;
//			
//			GLuint width = CGImageGetWidth(image.CGImage);
//			GLuint height = CGImageGetHeight(image.CGImage);
//			CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//			void *imageData = malloc( height * width * 4 );
//			CGContextRef context = CGBitmapContextCreate( imageData, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
//			CGColorSpaceRelease( colorSpace );
//			CGContextClearRect( context, CGRectMake( 0, 0, width, height ) );
//			CGContextDrawImage( context, CGRectMake( 0, 0, width, height ), image.CGImage );
//
//			glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
//			//GLuint errorcode = glGetError();
//			CGContextRelease(context);
//			
//			free(imageData);
//			[image release];
//		}
//		glEnable(GL_BLEND);
//
//	}
//	return self;
//}
+ (void)useDefaultTexture
{
	glBindTexture(GL_TEXTURE_2D, 0);
}

//- (void)bind
//{
//	//NSLog(@"Binding texture: %@ (OGL: %d", filename, texture[0]);
//	glBindTexture(GL_TEXTURE_2D, texture[0]);
//}

- (void)dealloc
{
	glDeleteTextures(1, &texture[0]);
	[filename release];
	[super dealloc];
}

- (id)initWithFilename:(NSString *)inFilename 
 andBindToTextureIndex:(int) index
					  width:(GLuint)inWidth 
					 height:(GLuint)inHeight {
	
	if ((self = [super init]))
	{
		glEnable(GL_TEXTURE_2D);
		
		self.filename = inFilename;
		glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
		
		/***************************************************************
		 * This may need to be moved
		 *************************Below This****************************/
		if (!__generatedTextures) {
			NSLog(@"textures generated");
			*texture = (GLuint) malloc(sizeof(GLuint) * NumberOfPlanets);
			glGenTextures(NumberOfPlanets, &texture[0]);
			__generatedTextures = YES;
		}
		
		glBindTexture(GL_TEXTURE_2D, texture[index]);
		/*************************Above This****************************/
		
		//glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR); 
		glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR); 
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
		glBlendFunc(GL_ONE, GL_SRC_COLOR);
		
		// Find the texture data from the file system
		NSData *texData = [NSData findTextDataForImageNamed:inFilename];
		
		// Assumes pvr4 is RGB not RGBA, which is how texturetool generates them
		if ([[inFilename pathExtension] isEqualToString:@"pvr4"])
			glCompressedTexImage2D(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG, inWidth, inHeight, 0, (inWidth * inHeight) / 2, [texData bytes]);
		else if ([[inFilename pathExtension] isEqualToString:@"pvr2"])
			glCompressedTexImage2D(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG, inWidth, inHeight, 0, (inWidth * inHeight) / 2, [texData bytes]);
		else
		{
			UIImage *image = [[UIImage alloc] initWithData:texData];
			if (image == nil)
				return nil;
			
			GLuint width = CGImageGetWidth(image.CGImage);
			GLuint height = CGImageGetHeight(image.CGImage);
			CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
			void *imageData = malloc( height * width * 4 );
			CGContextRef context = CGBitmapContextCreate( imageData, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
			CGColorSpaceRelease( colorSpace );
			CGContextClearRect( context, CGRectMake( 0, 0, width, height ) );
			CGContextDrawImage( context, CGRectMake( 0, 0, width, height ), image.CGImage );
			
			glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, imageData);
			//GLuint errorcode = glGetError();
			CGContextRelease(context);
			
			free(imageData);
			[image release];
		}
		glEnable(GL_BLEND);
		
	}
	return self;
}

- (void)bindToTextureIndex:(int) index
{
	//NSLog(@"Binding texture: %@ (OGL: %d", filename, texture[0]);
	glBindTexture(GL_TEXTURE_2D, texture[index]);
}
@end
