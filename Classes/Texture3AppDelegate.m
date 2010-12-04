//
//  Texture3AppDelegate.m
//  Texture3
//
//  Created by rcrebs on 9/24/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "Texture3AppDelegate.h"
#import "GLView.h"
#import "RCCamera.h"

@implementation Texture3AppDelegate

@synthesize window;
@synthesize glView;
@synthesize camera;

- (void)applicationDidFinishLaunching:(UIApplication *)application {

	// Allocate and initialize the camera Object
	camera = [[RCCamera alloc] init];

	glView.animationInterval = 1.0 / kRenderingFrequency;
	[glView startAnimation];

}


- (void)applicationWillResignActive:(UIApplication *)application {
	glView.animationInterval = 1.0 / kInactiveRenderingFrequency;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	glView.animationInterval = 1.0 / 60.0;
}

- (void)dealloc {
	[window release];
	[glView release];
	[super dealloc];
}

#pragma mark -
#pragma mark My Class Methods
/*
 * Returns instance of the app delegate. This can be used share application object data, 
 * instead of creating Static Objects or passing instances of objects through levels of 
 * different objects.
 */
+(Texture3AppDelegate*)sharedAppDelegate {
	return [UIApplication sharedApplication].delegate;
}
@end
