//
//  RCCamera.h
//  Texture3
//
//  Created by rcrebs on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR || TARGET_OS_EMBEDDED
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#else
#import <OpenGL/OpenGL.h>
#endif
#import <Foundation/Foundation.h>
#import "GLView.h"


@interface RCCamera : NSObject {
	CGPoint firstTouchPoint;
	CGPoint secondTouchPoint;
	GLuint rotate;
	GLfloat xRotation, yRotation, zoom;
	GLfloat degreee;
	
	BOOL secondTouchPointSet;
	
	GLView *view;
	UITouch *firstTouch;
}

@property (nonatomic, retain) GLView *view;
@property (nonatomic, retain) UITouch *firstTouch;
@property (nonatomic) CGPoint firstTouchPoint;
@property (nonatomic) CGPoint secondTouchPoint;

- (void)checkRun;
- (void)checkRise;
- (void)zoom:(NSArray*)arrayOfTouches;
-(void)zoomDifferenceOfPoint:(CGPoint)firstPoint 
						  andPoint:(CGPoint)secondPoint 
					  andNewPoint:(CGPoint)newFirstPoint 
					  andNewPoint:(CGPoint)newSecondPoint;
-(void)defaultZoom;

- (void)scroll:(NSArray*)arrayOfTouches;
- (void)transformForCameraPosition;

-(GLfloat)aPositionOnOneAxisAtPositionOfAnotherAxis:(GLfloat)position;
-(GLfloat)value:(GLfloat)value toThePositivePower:(GLint)exponent;
-(GLfloat)absoluteValue:(GLfloat)value;
@end
