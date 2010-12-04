//
//  RCCamera.m
//  Texture3
//
//  Created by rcrebs on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RCCamera.h"
#import "Texture3AppDelegate.h"
#import <math.h>

#define DefalutZoom 50.0f

@implementation RCCamera

@synthesize firstTouch;
@synthesize firstTouchPoint, secondTouchPoint;
@synthesize view;

-(id)init {
	[super init];
	
	self.view = [Texture3AppDelegate sharedAppDelegate].glView;
	zoom = 100;
	rotate = 0;
	return self;
}

- (void)checkRun {
	
}

- (void)checkRise {
	
}

#pragma mark -
#pragma mark Zooming Camera
- (void)zoom:(NSArray*)arrayOfTouches {
	CGPoint newFirstTouchPoint, newSecondTouchPoint;
	
	// Because touch events are order randomly the index of the first touch event must be Identified
	if ([arrayOfTouches indexOfObject:firstTouch] == 0) {
		newFirstTouchPoint = [[arrayOfTouches objectAtIndex:0] locationInView:self.view];
		newSecondTouchPoint = [[arrayOfTouches objectAtIndex:1] locationInView:self.view];
		if (!secondTouchPointSet) {
            secondTouchPoint = [[arrayOfTouches objectAtIndex:1] locationInView:self.view];
			secondTouchPointSet = YES;
		}
		
	}
	else {
		newFirstTouchPoint = [[arrayOfTouches objectAtIndex:1] locationInView:self.view];
		newSecondTouchPoint = [[arrayOfTouches objectAtIndex:0] locationInView:self.view];
		if (!secondTouchPointSet) {
            secondTouchPoint = [[arrayOfTouches objectAtIndex:0] locationInView:self.view];
			secondTouchPointSet = YES;
		}
	}
	
	// Calculate distances and the difference of distances
	[self zoomDifferenceOfPoint:firstTouchPoint andPoint:secondTouchPoint andNewPoint:newFirstTouchPoint andNewPoint:newSecondTouchPoint];
	
	// After camera zoom has taken place assign old touch points to the new for the next calculations
	firstTouchPoint = newFirstTouchPoint;
	secondTouchPoint = newSecondTouchPoint;
	
}

-(void)zoomDifferenceOfPoint:(CGPoint)firstPoint 
						  andPoint:(CGPoint)secondPoint 
					  andNewPoint:(CGPoint)newFirstPoint 
					  andNewPoint:(CGPoint)newSecondPoint
{
	// Calculate the distances of the two previous points and the two new touch points. Then caluclate the change in zoom.
	GLfloat distanceBetweenPreviousPoints = sqrt([self value:secondPoint.x - firstPoint.x toThePositivePower:2.0f] + [self value:secondPoint.y - firstPoint.y toThePositivePower:2.0f]);
	GLfloat distanceBetweenNewPoints = sqrt([self value:newSecondPoint.x - newFirstPoint.x toThePositivePower:2.0f] + [self value:newSecondPoint.y - newFirstPoint.y toThePositivePower:2.0f]);
	
	// Change in zoom
	GLfloat changeInZoom = (distanceBetweenNewPoints - distanceBetweenPreviousPoints);
	
	// Make sure the new zoom position is not less than 0.0. If it is, it is set to minimum zoom of 0.0.
	if (zoom - (changeInZoom / [self absoluteValue:changeInZoom]) > 0.0f) {
		GLfloat newZoom = zoom - (changeInZoom / [self absoluteValue:changeInZoom]);
		
		if (isnan(newZoom) ) {
			NSLog(@"nan found");
		}
		else {
			
			zoom = newZoom;
		}

	
	} 
	
}


-(void)defaultZoom
{	
	// Set zoom to default
	zoom = DefalutZoom;
}

#pragma mark -
#pragma mark Scrolling Camera
- (void)scroll:(NSArray*)arrayOfTouches {
	
	CGPoint moveToPoint = [[arrayOfTouches objectAtIndex:0] locationInView:self.view];
	
	if ([self absoluteValue: moveToPoint.x - firstTouchPoint.x] > [self absoluteValue:moveToPoint.y - firstTouchPoint.y]) {
        xRotation += (moveToPoint.x - firstTouchPoint.x) / 3.5;
		//[camera scrollCamerasPositionXByDifferenceOf:moveToPoint.x - firstTouchPoint.x];
	}
	else if ([self absoluteValue: moveToPoint.x - firstTouchPoint.x] < [self absoluteValue:moveToPoint.y - firstTouchPoint.y]) {
        yRotation += (moveToPoint.y - firstTouchPoint.y) / 3.5;
    }
	else {
		NSLog(@"Change not hadled");
	}
	
	firstTouchPoint.x = moveToPoint.x;
	firstTouchPoint.y = moveToPoint.y;
	
}

#pragma mark -
#pragma mark Transform
- (void)transformForCameraPosition { 
	
	glLoadIdentity();
	glTranslatef(0,0, -zoom);
	
	// TODO: This is need to implement Panning
	//glTranslatef(-10, 10, 0);
	/*********************************/
	
	glRotatef(xRotation, 0, 1, 0);
	glRotatef(yRotation, 1, 0, 0);
}

#pragma mark -
#pragma mark Math For Calculating Camera's Position
#pragma mark -

-(GLfloat)aPositionOnOneAxisAtPositionOfAnotherAxis:(GLfloat)position
{
	return sqrt(zoom - (position * position));
}

-(GLfloat)value:(GLfloat)value toThePositivePower:(GLint)exponent
{
	GLfloat newValue = value;
	
	if (exponent == 0.0f) {
		return 1.0f;
	}
	else {
		GLint count = 1;
		while (count < exponent) {
			
			newValue *= value;
			
			++count;
		}
	}
	
	return newValue;
}

-(GLfloat)absoluteValue:(GLfloat)value
{
	if (value < 0.0f) {
		return -value;
	}
	
	return value;
}
@end


