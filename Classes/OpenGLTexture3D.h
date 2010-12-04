//
//  OpenGLTexture3D.h
//  NeHe Lesson 06
//
//  Created by Jeff LaMarche on 12/24/08.
//  Copyright 2008 Jeff LaMarche Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface OpenGLTexture3D : NSObject {
	GLuint		texture[0];  
	NSString	*filename;
}
@property (nonatomic, retain) NSString *filename;
//- (id)initWithFilename:(NSString *)inFilename width:(GLuint)inWidth height:(GLuint)inHeight;
//- (void)bind;
+ (void)useDefaultTexture;

- (id)initWithFilename:(NSString *)inFilename andBindToTextureIndex:(int) index width:(GLuint)inWidth height:(GLuint)inHeight;
- (void)bindToTextureIndex:(int) index;
@end
