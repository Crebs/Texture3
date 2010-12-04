//
//  RCPlanetObject.h
//  PlayingWithOpenGLES
//
//  Created by rcrebs on 7/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "OpenGLCommon.h"
#import "OpenGLTexture3D.h"

@interface RCCelestialObject : NSObject {
	
	NSString *planetName;
	GLfloat rotate;
	GLfloat angle;
	GLfloat xPosition;
	GLfloat yPosition;
	GLfloat zPosition;
	GLint sign;
	
	GLfloat timeAtSpaceZero;
	
	// Physics Data for each planet
	GLfloat massOfOtherCelestialObject;
	GLfloat distanceFromOtherCelestialObject;
	GLfloat velosity;
	GLfloat acceleration;
	BOOL preparedForTopOfEllipse;
	BOOL preparedForBottomOfEllipse;
}

@property (nonatomic) IBOutlet GLfloat xPosition;
@property (nonatomic) IBOutlet GLfloat yPosition;
@property (nonatomic) IBOutlet GLfloat zPosition;
@property (nonatomic, retain) IBOutlet NSString *planetName;


-(id)createPlanetWithName:(NSString*)name 
massOfOtherClestialObject:(GLfloat)mass 
					  velocity:(GLfloat)initialVelocity 
					  distance:(GLfloat)distance 
			 withTextureData:(OpenGLTexture3D*)textures;

-(void)redrawCelestialObjectWithTextureData:(OpenGLTexture3D*)textures;
-(void)recalulatedAndDrawWithTextureData:(OpenGLTexture3D*)textures;
-(void)recalculateOrbit;
-(GLfloat) timeAtSpaceZero;
-(GLfloat) posNegSpaceAt:(GLfloat)time;
-(GLfloat) acceleration;
-(void)orbitSatelliteAround:(RCCelestialObject*)planet withTextureData:(OpenGLTexture3D*)textures;
@end
