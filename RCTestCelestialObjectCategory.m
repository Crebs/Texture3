//
//  RCTestCelestialObjectCategory.m
//  Texture3
//
//  Created by rcrebs on 10/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RCTestCelestialObjectCategory.h"
#import "RCPlanetVertex.h"
#import "Texture3AppDelegate.h"


@implementation RCCelestialObject (RCTestCelestialObjectCategory)

-(id)redrawWithTextureData:(OpenGLTexture3D*)textures 
					 xPosition:(GLfloat) xposition 
					 yPosition:(GLfloat)yposition
{
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_NORMAL_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
	glEnable(GL_BLEND);
	
	
	// put camera object here;
	[[Texture3AppDelegate sharedAppDelegate].camera transformForCameraPosition];
	
	// Initialize and Create a Planet. 
	TexturedVertexData3D *planetStruct = getStruct(planetName);
	
	/*****************************************************************
	 *  Get texture for Planet .
	 *****************************Below This***************************/
	[textures bindToTextureIndex:getIndexForPlanetName(planetName)];
	/*****************************Above This***************************/
	
	glTranslatef(xposition, yposition, -20.0f); 
	glRotatef(++rotate, 0.0, 1.0, 0.0);
	
	// Plot Vertex 
	glVertexPointer(3, GL_FLOAT, sizeof(TexturedVertexData3D), &planetStruct[0].vertex);
	glNormalPointer(GL_FLOAT, sizeof(TexturedVertexData3D), &planetStruct[0].normal);
	glTexCoordPointer(2, GL_FLOAT, sizeof(TexturedVertexData3D), &planetStruct[0].texCoord);
	glDrawArrays(GL_TRIANGLES, 0, getNumberOfVerticeForPlanetNamed(planetName));
	
	// Clean up shop
	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_NORMAL_ARRAY);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisable(GL_TEXTURE_2D);
	glDisable(GL_BLEND);
	
	return self;

}

@end
