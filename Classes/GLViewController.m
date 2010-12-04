//
//  GLViewController.m
//  Texture3
//
//  Created by rcrebs on 9/24/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "GLViewController.h"
#import "ConstantsAndMacros.h"
#import "OpenGLCommon.h"
#import "RCTestCelestialObjectCategory.h"



@implementation GLViewController

@synthesize earth, sun, mercury, venus, eMoon, mars, jupiter, deathStar;
@synthesize textures;
@synthesize appDelegate;

- (void)drawView:(UIView *)theView
{
	static GLfloat  rot = 0.0;

	glColor4f(0.0, 0.0, 0.0, 0.0);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glLoadIdentity();
	
    [sun redrawCelestialObjectWithTextureData:textures];
    
	 [earth recalulatedAndDrawWithTextureData:textures];
    [eMoon orbitSatelliteAround:earth withTextureData:textures];
    
    [mercury recalulatedAndDrawWithTextureData:textures];
	
    [venus recalulatedAndDrawWithTextureData:textures];
	
    [mars recalulatedAndDrawWithTextureData:textures];
    
    [jupiter recalulatedAndDrawWithTextureData:textures];
    [deathStar orbitSatelliteAround:mars withTextureData:textures];
    
	
	static NSTimeInterval lastDrawTime;
	if (lastDrawTime){
		NSTimeInterval timeSinceLastDraw = [NSDate timeIntervalSinceReferenceDate] - lastDrawTime;
		rot += 60 * timeSinceLastDraw;
	}
	lastDrawTime = [NSDate timeIntervalSinceReferenceDate];
    
}

-(void)setupView:(GLView*)view
{

	
	const GLfloat zNear = 0.01, zFar = 1000.0, fieldOfView = 45.0; 
	GLfloat size; 
	glEnable(GL_DEPTH_TEST);
	glMatrixMode(GL_PROJECTION); 
	size = zNear * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0); 
	CGRect rect = view.bounds; 
	glFrustumf(-size, size, -size / (rect.size.width / rect.size.height), size / 
				  (rect.size.width / rect.size.height), zNear, zFar); 
	glViewport(0, 0, rect.size.width, rect.size.height);  
	glMatrixMode(GL_MODELVIEW);
	
	// Check if the textures need  memory to be allocated 
	if (textures == NULL) {
        textures = [OpenGLTexture3D alloc];
	}
	
	// Get the App Delegate for Camera manipulation
	appDelegate = [Texture3AppDelegate sharedAppDelegate];

	// Create Planet Objects
	earth = [[RCCelestialObject alloc] createPlanetWithName:@"earth" 
											massOfOtherClestialObject:1.9891e30f 
																  velocity:3.00e1f 
																  distance:1.82e11f 
														 withTextureData:textures];
	
	sun = [[RCCelestialObject alloc] createPlanetWithName:@"sun"
										 massOfOtherClestialObject:0.0f 
																velocity:0.0f 
																distance:0.0f 
													  withTextureData:textures];
	
	mercury = [[RCCelestialObject alloc] createPlanetWithName:@"mercury"
											  massOfOtherClestialObject:1.9891e30 
																	 velocity:4.79e1
																	 distance:5.79e10 
															withTextureData:textures];
	
	venus = [[RCCelestialObject alloc] createPlanetWithName:@"venus" 
											massOfOtherClestialObject:1.9891e30
																  velocity:3.5e1
																  distance:1.07e11 
														 withTextureData:textures];
	
	eMoon = [[RCCelestialObject alloc] createPlanetWithName:@"emoon" 
											  massOfOtherClestialObject:5.97e24 
																	 velocity:4.02e0 * 8500
																	 distance:10.5e6 
														 withTextureData:textures];
    
    mars = [[RCCelestialObject alloc] createPlanetWithName:@"mars" 
                                 massOfOtherClestialObject:1.9891e30f 
                                                  velocity:2.41e1
                                                  distance:2.30e11
                                           withTextureData:textures];
    
    jupiter = [[RCCelestialObject alloc] createPlanetWithName:@"jupiter" 
                                    massOfOtherClestialObject:1.9891e30f 
                                                     velocity:1.307e1f 
                                                     distance:4.78e11f 
                                              withTextureData:textures];
    
    deathStar = [[RCCelestialObject alloc] createPlanetWithName:@"emoon" 
                                      massOfOtherClestialObject:5.97e24 
                                                       velocity:3.02e0 * 8500 
                                                       distance:13.5e6 
                                                withTextureData:textures];
    
    
	

	glEnable(GL_LIGHTING);
	
	// Turn the first light on
	glEnable(GL_LIGHT0);
	
	// Define the ambient component of the first light
	static const Color3D light0Ambient[] = {{0.4, 0.4, 0.4, 1.0}};
	glLightfv(GL_LIGHT0, GL_AMBIENT, (const GLfloat *)light0Ambient);
	
	// Define the diffuse component of the first light
	static const Color3D light0Diffuse[] = {{0.8, 0.8, 0.8, 1.0}};
	glLightfv(GL_LIGHT0, GL_DIFFUSE, (const GLfloat *)light0Diffuse);
	
	// Define the position of the first light
	// const GLfloat light0Position[] = {10.0, 10.0, 10.0}; 
	static const Vertex3D light0Position[] = {{10.0, 10.0, 10.0}};
	glLightfv(GL_LIGHT0, GL_POSITION, (const GLfloat *)light0Position);	
}

- (void)dealloc 
{
    [super dealloc];
}

#pragma mark -
#pragma mark TouchEvents

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSSet *touchEvents = [event allTouches];
	NSArray *arrayOfTouches = [touchEvents allObjects];
	
	// The first touch to keep track of touching for pinch zoom.
	appDelegate.camera.firstTouch = [arrayOfTouches objectAtIndex:0];
	appDelegate.camera.firstTouchPoint = [appDelegate.camera.firstTouch locationInView:self.view];
	
	if ([arrayOfTouches count] == 1) {
		// Check for tap counts to perform other camera view manipulations
		switch ([appDelegate.camera.firstTouch tapCount]) {
			case 2:
				[appDelegate.camera defaultZoom];
				break;
			default:
				break;
		}
		
	}
	else if ([touchEvents count] == 2) { // pinching action is taking place
		appDelegate.camera.secondTouchPoint = [[arrayOfTouches objectAtIndex:1] locationInView:self.view];
	}
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSSet *touchEvents = [event allTouches];
	NSArray *arrayOfTouches = [touchEvents allObjects];

	
	if ([arrayOfTouches count] == 2) {
		[appDelegate.camera zoom: arrayOfTouches];
				
	}
	else {
        [appDelegate.camera scroll:arrayOfTouches];
	}


}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
}

@end
