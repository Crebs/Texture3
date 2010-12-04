//
//  GLViewController.h
//  Texture3
//
//  Created by rcrebs on 9/24/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLView.h"
#import "OpenGLCommon.h"
#import "OpenGLTexture3D.h"
#import "RCCelestialObject.h"
#import "Texture3AppDelegate.h"

@interface GLViewController : UIViewController <GLViewDelegate>
{
	OpenGLTexture3D *textures;
	RCCelestialObject *earth;
	RCCelestialObject *sun;
	RCCelestialObject *mercury;
	RCCelestialObject *venus;
	RCCelestialObject *eMoon;
    RCCelestialObject *mars;
    RCCelestialObject *jupiter;
    RCCelestialObject *deathStar;
	Texture3AppDelegate *appDelegate;
    
		
}

@property (nonatomic, retain) OpenGLTexture3D *textures;
@property (nonatomic, retain) RCCelestialObject *earth;
@property (nonatomic, retain) RCCelestialObject *sun;
@property (nonatomic, retain) RCCelestialObject *mercury;
@property (nonatomic, retain) RCCelestialObject *venus;
@property (nonatomic, retain) RCCelestialObject *eMoon;
@property (nonatomic, retain) RCCelestialObject *mars;
@property (nonatomic, retain) RCCelestialObject *jupiter;
@property (nonatomic, retain) RCCelestialObject *deathStar;
@property (nonatomic, retain) Texture3AppDelegate *appDelegate;

@end
