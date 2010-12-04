//
//  Texture3AppDelegate.h
//  Texture3
//
//  Created by rcrebs on 9/24/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCCamera.h"

@class GLView;

@interface Texture3AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GLView *glView;
	RCCamera *camera;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GLView *glView;
@property (nonatomic, retain) RCCamera *camera;

+(Texture3AppDelegate*)sharedAppDelegate;

@end

