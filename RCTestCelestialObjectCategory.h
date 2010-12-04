//
//  RCTestCelestialObjectCategory.h
//  Texture3
//
//  Created by rcrebs on 10/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCCelestialObject.h"

@interface RCCelestialObject (RCTestCelestialObjectCategory) 

-(id)redrawWithTextureData:(OpenGLTexture3D*)textures 
					  xPosition:(GLfloat) xposition 
					  yPosition:(GLfloat)yposition;

@end
