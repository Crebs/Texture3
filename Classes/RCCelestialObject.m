//
//  RCPlanetObject.m
//  PlayingWithOpenGLES
//
//  Created by rcrebs on 7/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RCCelestialObject.h"
#import "GLViewController.h"
#import "RCPlanetVertex.h"


#define UniversalGravityConstant 6.6742e-11
#define ConstnatTime 200.0
#define VelosityScaleConstant 10000.0

@implementation RCCelestialObject

@synthesize planetName, xPosition, yPosition, zPosition;


#pragma mark -
#pragma mark RCOpenGLES Drawing Functions
#pragma mark -
-(id)createPlanetWithName:(NSString*)name 
massOfOtherClestialObject:(GLfloat)mass
					  velocity:(GLfloat)initialVelocity 
					  distance:(GLfloat)distance 
			 withTextureData:(OpenGLTexture3D*) textures
{
	[super init];
	
	rotate = 0;
	
	// Characteristics of Planet
	planetName = name;
	massOfOtherCelestialObject = mass;
	velosity = initialVelocity;
	distanceFromOtherCelestialObject = distance;
	
	// For elliptical orbit of planet
	preparedForTopOfEllipse = NO;
	preparedForBottomOfEllipse = NO;
	
	// Some physics stuff
	acceleration = [self acceleration];
	timeAtSpaceZero = [self timeAtSpaceZero];
	
	// Initial Position of Planet
	timeAtSpaceZero = [self timeAtSpaceZero];
	   
	xPosition = 0.0f;
	yPosition = 0.0f;
	zPosition = 0.0f;
	
	// Initialize texture data
	// Give OpenGL ES the ability to bind each image
	[textures initWithFilename: getImageForPlanet(getIndexForPlanetName(planetName)) 
		  andBindToTextureIndex:getIndexForPlanetName(planetName) 
								width:512 
							  height:512];
	
	return self;
}

-(void)recalculateOrbit
{	
	// Calculate position of planet on screen
	if (zPosition > 0 || xPosition <= -timeAtSpaceZero) 
	{
		// Check to see if clean up is needed
	  if (!preparedForTopOfEllipse) {
			xPosition = timeAtSpaceZero * -1;
			preparedForTopOfEllipse = YES;
			preparedForBottomOfEllipse = NO;

	  }		
		
	  xPosition += 1.0 / ConstnatTime;
	  zPosition = [self posNegSpaceAt:xPosition];
	  
		
	}
	else if (zPosition <= 0 || xPosition >= timeAtSpaceZero ) 
	{
		// Check if clean up is need for bottom of elips
		if(!preparedForBottomOfEllipse)
		 {
			xPosition = timeAtSpaceZero;
			preparedForBottomOfEllipse = YES;
			preparedForTopOfEllipse = NO;

		 }
		xPosition -= 1.0 / ConstnatTime;
	  zPosition = [self posNegSpaceAt:xPosition] * -1;
	}
	
	yPosition = 0.0f;
	angle = xPosition;

}

-(void)redrawCelestialObjectWithTextureData:(OpenGLTexture3D*)textures
{	
	static GLfloat  rot = 0.0;
	
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_NORMAL_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
	
	// put camera object here;
	[[Texture3AppDelegate sharedAppDelegate].camera transformForCameraPosition];
	
	// Initialize and Create a Planet. 
	TexturedVertexData3D *planetStruct = getStruct(planetName);
	
	/*****************************************************************
	 *  Get texture for Planet .
	 *****************************Below This***************************/
	[textures bindToTextureIndex:getIndexForPlanetName(planetName)];
	/*****************************Above This***************************/	
	
	glTranslatef(xPosition, yPosition, zPosition); 
	glRotatef(rot += 0.01, 0.0, 1.0, 0.0);
	
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
}

-(void)recalulatedAndDrawWithTextureData:(OpenGLTexture3D*)textures
{
	[self recalculateOrbit];
	[self redrawCelestialObjectWithTextureData:textures];
}

#pragma mark -
#pragma mark Functions for Satellites Only
#pragma mark -
-(void)orbitSatelliteAround:(RCCelestialObject*)planet withTextureData:(OpenGLTexture3D*)textures
{
	GLfloat tempXPosition, tempZPosition;
	[self recalculateOrbit];
	// Hold acctual positons calculated 
	tempXPosition = xPosition;
	tempZPosition = zPosition;
	
	// Change the orgin of Satellite
	xPosition += planet.xPosition;
	zPosition += planet.zPosition;
	
	// Draw it
	[self redrawCelestialObjectWithTextureData:textures];
	
	// Set Satellite Positions back for next calculation
	xPosition = tempXPosition;
	zPosition = tempZPosition;
	
}

#pragma mark -
#pragma mark RCMathFunctions
#pragma mark -
-(GLfloat) timeAtSpaceZero
{	
	// Check for division by zero
	if (acceleration == 0.0f) {
		return 0.0f;
	}
	
	return sqrt(2 / acceleration);
	
}

-(GLfloat) posNegSpaceAt:(GLfloat)time
{
	return sqrt((( 1 - (acceleration * (time * time)) / 2) / velosity) * VelosityScaleConstant); 
}

-(GLfloat) acceleration
{
	// Check for division by zero
	if (distanceFromOtherCelestialObject == 0.0f) {
		return 0.0f;
	}
	
	return ((UniversalGravityConstant * massOfOtherCelestialObject) / (distanceFromOtherCelestialObject * distanceFromOtherCelestialObject));
}
@end
