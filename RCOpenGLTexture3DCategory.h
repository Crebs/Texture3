//
//  RCOpenGLTexture3DCategory.h
//  Texture3
//
//  Created by rcrebs on 10/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenGLTexture3D.h"



@interface OpenGLTexture3D (RCOpenGLTexture3DCategory)

- (id)initWithFilename:(NSString *)inFilename andBindToTextureIndex:(int) index width:(GLuint)inWidth height:(GLuint)inHeight;

- (void)bindToTextureIndex:(int) index;
@end
