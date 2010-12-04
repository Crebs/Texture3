// 
// RCPlanetVertex.h
//
// Created by Riley Crebs
// 
// This contains static binaries and and accessors for OpenGL ES vertex data.  
//
#import "RCEarth.h"
#import "RCSun2.h"
#import "RCMercury.h"
#import "RCVenus.h"
#import "RCeMoon.h"
#import "RCMars.h"
#import "RCJupiter.h"
#import "RCNSDataCategory.h"
#import "RCNSStringCategory.h"

#define NumberOfPlanets  10
static TexturedVertexData3D* arrayOfPlanetStructs[NumberOfPlanets];

static int numberOfVertices[NumberOfPlanets];
//static NSMutableArray* arrayOfTextures;

#pragma mark -
#pragma mark Functions Specific Only to this File
/********************************************************************
 * Check if independent arrays are initialized
 *******************************************************************/
static inline bool isArrayInitialized() {
	return (arrayOfPlanetStructs[0] && numberOfVertices[0]);
}

// TODO: Map texture file name  to Planet
/********************************************************************
 * Map Texture to correct Planet
 *******************************************************************/
static inline NSString* getImageForPlanet(int planetNumber) {
	switch (planetNumber) {
		case 0:
			return @"earthmapthumb.jpg";
			break;
		case 1:
			return @"SunTexture_2048.jpg";
			break;
		case 2:
			return @"mercurymapthumb.jpg";
			break;
		case 3:
			return @"venusmapthumb.jpg";
			break;
		case 4:
			return @"moonmapthumb.jpg";
			break;
        case 5:
            return @"mars.jpg";
            break;
        case 6:
            return @"jupiter.jpg";
            break;
		default:
			return 0;
			break;
	}
}

/********************************************************************
 * Map fileName to correct index
 *******************************************************************/
static inline int getIndexForFileName(NSString *fileName) {
	if ([fileName isSameStringAs:@"earthmapthumb.jpg"]) {
		return 0;
	}
	else if ([fileName isSameStringAs:@"SunTexture_2048.jpg"]) {
		return 1;
	}
	else if ([fileName isSameStringAs:@"mercurymapthumb.jpg"]) {
		return 2;
	}
	else if ([fileName isSameStringAs:@"venusmapthumb.jpg"]) {
		return 3;
	}
	else if ([fileName isSameStringAs:@"moonmapthumb.jpg"]) {
		return 4;
	}
    else if ([fileName isSameStringAs:@"mars.jpg"]) {
        return 5;
    }
    else if ([fileName isSameStringAs:@"jupiter.jpg"]) {
        return 6;
    }
	else {
		return 0;
	}
}

/********************************************************************
 * Map Array indexes to a specific string name
 *******************************************************************/
static inline int getIndexForPlanetName(NSString* planetName) {
	// Look for mapping of Planet number
	if ([planetName isSameStringAs:@"earth"]) {
		return 0;
	}
	else if ([planetName isSameStringAs:@"sun"]) {
		return 1;
	}
	else if ([planetName isSameStringAs:@"mercury"]) {
		return 2;
	}
	else if ([planetName isSameStringAs:@"venus"]) {
		return 3;
	}
	else if ([planetName isSameStringAs:@"emoon"]) {
		return 4;
	}
    else if ([planetName isSameStringAs:@"mars"]) {
        return 5;
    }
    else if ([planetName isSameStringAs:@"jupiter"]) {
        return 6;
    }
	else {
		return 0;
	}
}

/********************************************************************
 * Make array of  TexturedVertexData3D for future mapping
 *******************************************************************/
static inline void initializeVertexMapping() {
	// Initialize  Planet Vertice
	arrayOfPlanetStructs[0] = (TexturedVertexData3D*) RCEarthVertexData;
	arrayOfPlanetStructs[1] = (TexturedVertexData3D*) RCSunVertexData;
	arrayOfPlanetStructs[2] = (TexturedVertexData3D*) RCMercuryVertexData;
	arrayOfPlanetStructs[3] = (TexturedVertexData3D*) RCVenusVertexData;
	arrayOfPlanetStructs[4] = (TexturedVertexData3D*) RCeMoonVertexData;
    arrayOfPlanetStructs[5] = (TexturedVertexData3D*) RCMarsVertexData;
    arrayOfPlanetStructs[6] = (TexturedVertexData3D*) RCJupiterVertexData;

	// Initialize Number of Vertice for each Planet
	numberOfVertices[0] = kRCEarthNumberOfVertices;
	numberOfVertices[1] = kRCSunNumberOfVertices;
	numberOfVertices[2] = kRCMercuryNumberOfVertices;
	numberOfVertices[3] = kRCVenusNumberOfVertices;
	numberOfVertices[4] = kRCeMoonNumberOfVertices;
    numberOfVertices[5] = kRCMarsNumberOfVertices;
    numberOfVertices[6] = kRCJupiterNumberOfVertices;
}

#pragma mark -
#pragma mark Accessor Functions for Planet Vertice
/********************************************************************
 * Used for mapping planet name to array
 *******************************************************************/
static inline TexturedVertexData3D* getStruct(NSString* planetName) {
	
	// Check if planetStruct need to be initialized
	if (!isArrayInitialized()) {
		initializeVertexMapping();
	}
	
	return arrayOfPlanetStructs[getIndexForPlanetName(planetName)] ;
}

/********************************************************************
 * Get number of  Vertex for Planet mapped to String name (he key)
 *******************************************************************/
static inline int getNumberOfVerticeForPlanetNamed(NSString *planetName) {
	// Check if planetStruct need to be initialized
	if (!isArrayInitialized()) {
		initializeVertexMapping();
	}
	
	return numberOfVertices[getIndexForPlanetName(planetName)];
}



